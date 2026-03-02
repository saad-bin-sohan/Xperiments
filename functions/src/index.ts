import * as admin from 'firebase-admin';
import { DateTime } from 'luxon';
import { logger } from 'firebase-functions';
import { onDocumentCreated, onDocumentUpdated } from 'firebase-functions/v2/firestore';
import { onSchedule } from 'firebase-functions/v2/scheduler';

admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

const USERS = 'users';
const EXPERIMENTS = 'experiments';
const CHECKINS = 'checkins';
const DEVICES = 'devices';

const NUDGE_HOUR_LOCAL = 9;

interface UserPreferences {
  notificationsEnabled?: boolean;
  nudgeDaysThreshold?: number;
  friendAccountabilityEnabled?: boolean;
  friendEmails?: string[];
  timezone?: string;
}

interface UserDoc {
  displayName?: string;
  email?: string;
  disabled?: boolean;
  preferences?: UserPreferences;
}

interface ExperimentDoc {
  userId?: string;
  name?: string;
  startDate?: admin.firestore.Timestamp;
  status?: string;
}

interface DeviceDoc {
  token?: string;
  notificationsEnabled?: boolean;
}

export const onCheckinCreate = onDocumentCreated(
  `${EXPERIMENTS}/{experimentId}/${CHECKINS}/{checkinId}`,
  async (event) => {
    const snapshot = event.data;
    if (!snapshot) {
      return;
    }

    const experimentId = event.params.experimentId;
    const experimentSnap = await db.collection(EXPERIMENTS).doc(experimentId).get();
    if (!experimentSnap.exists) {
      return;
    }

    const experiment = experimentSnap.data() as ExperimentDoc;
    const actorUserId = experiment.userId;
    if (!actorUserId) {
      return;
    }

    const actorUserSnap = await db.collection(USERS).doc(actorUserId).get();
    if (!actorUserSnap.exists) {
      return;
    }

    const actor = actorUserSnap.data() as UserDoc;
    const prefs = actor.preferences ?? {};

    if (!(prefs.notificationsEnabled === true && prefs.friendAccountabilityEnabled === true)) {
      return;
    }

    const friendEmails = (prefs.friendEmails ?? []).map((email) => email.trim()).filter(Boolean);
    if (friendEmails.length === 0) {
      return;
    }

    const recipients = await findUsersByEmails(friendEmails);
    const recipientUserIds = recipients
      .filter((doc) => {
        const user = doc.data() as UserDoc;
        return doc.id !== actorUserId && user.disabled !== true && user.preferences?.notificationsEnabled === true;
      })
      .map((doc) => doc.id);

    if (recipientUserIds.length === 0) {
      return;
    }

    const tokens = await getUserDeviceTokens(recipientUserIds);
    if (tokens.length === 0) {
      return;
    }

    const actorName = actor.displayName?.trim() || actor.email?.trim() || 'Someone';
    const experimentName = experiment.name?.trim() || 'an experiment';

    await sendNotificationToTokens(tokens, {
      title: 'Friend accountability',
      body: `${actorName} just checked in on ${experimentName}.`,
      data: {
        type: 'friend_checkin',
        experimentId,
      },
    });
  },
);

export const dailyNudgeCheck = onSchedule('0 * * * *', async () => {
  const usersSnap = await db
    .collection(USERS)
    .where('preferences.notificationsEnabled', '==', true)
    .get();

  for (const userSnap of usersSnap.docs) {
    const user = userSnap.data() as UserDoc;
    if (user.disabled === true) {
      continue;
    }

    const prefs = user.preferences ?? {};
    const threshold = prefs.nudgeDaysThreshold ?? 7;
    if (threshold <= 0) {
      continue;
    }

    const zone = (prefs.timezone && prefs.timezone.trim()) || 'UTC';
    const nowLocal = DateTime.now().setZone(zone);
    const effectiveNow = nowLocal.isValid ? nowLocal : DateTime.now().setZone('UTC');
    const effectiveZone = effectiveNow.zoneName ?? 'UTC';

    if (effectiveNow.hour !== NUDGE_HOUR_LOCAL) {
      continue;
    }

    const activeExperiments = await db
      .collection(EXPERIMENTS)
      .where('userId', '==', userSnap.id)
      .where('status', '==', 'active')
      .get();

    if (activeExperiments.empty) {
      continue;
    }

    const userTokens = await getUserDeviceTokens([userSnap.id]);
    if (userTokens.length === 0) {
      continue;
    }

    for (const experimentSnap of activeExperiments.docs) {
      const experiment = experimentSnap.data() as ExperimentDoc;
      const latestCheckinSnap = await db
        .collection(EXPERIMENTS)
        .doc(experimentSnap.id)
        .collection(CHECKINS)
        .orderBy('date', 'desc')
        .limit(1)
        .get();

      let reference: DateTime | null = null;
      if (!latestCheckinSnap.empty) {
        const latest = latestCheckinSnap.docs[0].data();
        const rawDate = latest.date as admin.firestore.Timestamp | undefined;
        if (rawDate) {
          reference = DateTime.fromJSDate(rawDate.toDate()).setZone(effectiveZone);
        }
      }

      if (!reference && experiment.startDate) {
        reference = DateTime.fromJSDate(experiment.startDate.toDate()).setZone(effectiveZone);
      }

      if (!reference) {
        continue;
      }

      const daysSince = Math.floor(
        effectiveNow.startOf('day').diff(reference.startOf('day'), 'days').days,
      );

      if (daysSince < threshold) {
        continue;
      }

      const experimentName = experiment.name?.trim() || 'This experiment';
      await sendNotificationToTokens(userTokens, {
        title: 'Gentle nudge',
        body: `${experimentName} hasn't been checked in for ${threshold} days. Still running?`,
        data: {
          type: 'nudge',
          experimentId: experimentSnap.id,
        },
      });
    }
  }
});

export const onUserDisabled = onDocumentUpdated(`${USERS}/{userId}`, async (event) => {
  const before = event.data?.before?.data() as UserDoc | undefined;
  const after = event.data?.after?.data() as UserDoc | undefined;

  if (!before || !after) {
    return;
  }

  if (before.disabled === true || after.disabled !== true) {
    return;
  }

  const userId = event.params.userId;
  try {
    await admin.auth().updateUser(userId, { disabled: true });
  } catch (error) {
    logger.error('Failed to disable auth user', { userId, error });
  }
});

async function findUsersByEmails(
  emails: string[],
): Promise<FirebaseFirestore.QueryDocumentSnapshot<FirebaseFirestore.DocumentData>[]> {
  const chunks = chunk(emails, 10);
  const docs: FirebaseFirestore.QueryDocumentSnapshot<FirebaseFirestore.DocumentData>[] = [];

  for (const emailChunk of chunks) {
    const snap = await db.collection(USERS).where('email', 'in', emailChunk).get();
    docs.push(...snap.docs);
  }

  return docs;
}

async function getUserDeviceTokens(userIds: string[]): Promise<string[]> {
  const tokenSet = new Set<string>();

  for (const userId of userIds) {
    const devicesSnap = await db
      .collection(USERS)
      .doc(userId)
      .collection(DEVICES)
      .where('notificationsEnabled', '==', true)
      .get();

    for (const deviceSnap of devicesSnap.docs) {
      const device = deviceSnap.data() as DeviceDoc;
      const token = device.token?.trim();
      if (token) {
        tokenSet.add(token);
      }
    }
  }

  return [...tokenSet];
}

async function sendNotificationToTokens(
  tokens: string[],
  payload: { title: string; body: string; data: Record<string, string> },
): Promise<void> {
  if (tokens.length === 0) {
    return;
  }

  const batches = chunk(tokens, 500);
  for (const batch of batches) {
    await messaging.sendEachForMulticast({
      tokens: batch,
      notification: {
        title: payload.title,
        body: payload.body,
      },
      data: payload.data,
    });
  }
}

function chunk<T>(items: T[], size: number): T[][] {
  const result: T[][] = [];
  for (let i = 0; i < items.length; i += size) {
    result.push(items.slice(i, i + size));
  }
  return result;
}
