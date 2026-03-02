import { DateTime } from 'luxon';
import { onDocumentCreated } from 'firebase-functions/v2/firestore';
import { onSchedule } from 'firebase-functions/v2/scheduler';
import { CHECKINS, DEVICES, EXPERIMENTS, NUDGE_HOUR_LOCAL, USERS } from './shared/constants';
import { db, messaging } from './shared/firebase';
import { incrementGlobalCounter } from './shared/counters';
import type { DeviceDoc, ExperimentDoc, UserDoc } from './shared/types';

export const onCheckinCreate = onDocumentCreated(
  `${EXPERIMENTS}/{experimentId}/${CHECKINS}/{checkinId}`,
  async (event) => {
    const snapshot = event.data;
    if (!snapshot) {
      return;
    }

    await incrementGlobalCounter('totalCheckins', 1);

    const experimentId = event.params.experimentId;
    const experimentSnapshot = await db.collection(EXPERIMENTS).doc(experimentId).get();
    if (!experimentSnapshot.exists) {
      return;
    }

    const experiment = experimentSnapshot.data() as ExperimentDoc;
    const actorUserId = experiment.userId;
    if (!actorUserId) {
      return;
    }

    const actorUserSnapshot = await db.collection(USERS).doc(actorUserId).get();
    if (!actorUserSnapshot.exists) {
      return;
    }

    const actor = actorUserSnapshot.data() as UserDoc;
    const preferences = actor.preferences ?? {};
    if (!(preferences.notificationsEnabled === true && preferences.friendAccountabilityEnabled === true)) {
      return;
    }

    const friendEmails = (preferences.friendEmails ?? []).map((email) => email.trim()).filter(Boolean);
    if (friendEmails.length === 0) {
      return;
    }

    const recipients = await findUsersByEmails(friendEmails);
    const recipientUserIds = recipients
      .filter((recipient) => {
        const userData = recipient.data() as UserDoc;
        return (
          recipient.id !== actorUserId &&
          userData.disabled !== true &&
          userData.preferences?.notificationsEnabled === true
        );
      })
      .map((recipient) => recipient.id);

    if (recipientUserIds.length === 0) {
      return;
    }

    const recipientTokens = await getUserDeviceTokens(recipientUserIds);
    if (recipientTokens.length === 0) {
      return;
    }

    const actorName = actor.displayName?.trim() || actor.email?.trim() || 'Someone';
    const experimentName = experiment.name?.trim() || 'an experiment';

    await sendNotificationToTokens(recipientTokens, {
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
  const usersSnapshot = await db
    .collection(USERS)
    .where('preferences.notificationsEnabled', '==', true)
    .get();

  for (const userSnapshot of usersSnapshot.docs) {
    const user = userSnapshot.data() as UserDoc;
    if (user.disabled === true) {
      continue;
    }

    const preferences = user.preferences ?? {};
    const threshold = preferences.nudgeDaysThreshold ?? 7;
    if (threshold <= 0) {
      continue;
    }

    const zone = (preferences.timezone && preferences.timezone.trim()) || 'UTC';
    const nowInUserZone = DateTime.now().setZone(zone);
    const effectiveNow = nowInUserZone.isValid ? nowInUserZone : DateTime.now().setZone('UTC');
    const effectiveZone = effectiveNow.zoneName ?? 'UTC';

    if (effectiveNow.hour !== NUDGE_HOUR_LOCAL) {
      continue;
    }

    const activeExperimentsSnapshot = await db
      .collection(EXPERIMENTS)
      .where('userId', '==', userSnapshot.id)
      .where('status', '==', 'active')
      .get();

    if (activeExperimentsSnapshot.empty) {
      continue;
    }

    const tokens = await getUserDeviceTokens([userSnapshot.id]);
    if (tokens.length === 0) {
      continue;
    }

    for (const experimentSnapshot of activeExperimentsSnapshot.docs) {
      const experiment = experimentSnapshot.data() as ExperimentDoc;
      const latestCheckinSnapshot = await db
        .collection(EXPERIMENTS)
        .doc(experimentSnapshot.id)
        .collection(CHECKINS)
        .orderBy('date', 'desc')
        .limit(1)
        .get();

      let reference: DateTime | null = null;
      if (!latestCheckinSnapshot.empty) {
        const latestData = latestCheckinSnapshot.docs[0].data();
        const rawDate = latestData.date as FirebaseFirestore.Timestamp | undefined;
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
      await sendNotificationToTokens(tokens, {
        title: 'Gentle nudge',
        body: `${experimentName} hasn't been checked in for ${threshold} days. Still running?`,
        data: {
          type: 'nudge',
          experimentId: experimentSnapshot.id,
        },
      });
    }
  }
});

async function findUsersByEmails(
  emails: string[],
): Promise<FirebaseFirestore.QueryDocumentSnapshot<FirebaseFirestore.DocumentData>[]> {
  const chunks = chunk(emails, 10);
  const docs: FirebaseFirestore.QueryDocumentSnapshot<FirebaseFirestore.DocumentData>[] = [];

  for (const emailChunk of chunks) {
    const snapshot = await db.collection(USERS).where('email', 'in', emailChunk).get();
    docs.push(...snapshot.docs);
  }

  return docs;
}

async function getUserDeviceTokens(userIds: string[]): Promise<string[]> {
  const tokenSet = new Set<string>();

  for (const userId of userIds) {
    const devicesSnapshot = await db
      .collection(USERS)
      .doc(userId)
      .collection(DEVICES)
      .where('notificationsEnabled', '==', true)
      .get();

    for (const deviceSnapshot of devicesSnapshot.docs) {
      const device = deviceSnapshot.data() as DeviceDoc;
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
  payload: {
    title: string;
    body: string;
    data: Record<string, string>;
  },
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
  for (let index = 0; index < items.length; index += size) {
    result.push(items.slice(index, index + size));
  }
  return result;
}
