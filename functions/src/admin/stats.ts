import { onCall } from 'firebase-functions/v2/https';
import { FieldPath } from 'firebase-admin/firestore';
import { assertAdmin } from '../shared/adminGuard';
import { CHECKINS, EXPERIMENTS, USERS } from '../shared/constants';
import { db } from '../shared/firebase';
import { readGlobalStats, setGlobalStats } from '../shared/counters';

interface AdminBackfillStatsRequest {
  scope: 'global' | 'user_experiment_counts' | 'all';
}

interface AdminBackfillStatsResponse {
  ok: boolean;
  scope: string;
  updatedAtIso: string;
}

export const adminGetBasicStats = onCall(async (request) => {
  await assertAdmin(request.auth?.uid);
  return readGlobalStats();
});

export const adminBackfillStats = onCall(
  { timeoutSeconds: 540, memory: '1GiB' },
  async (request): Promise<AdminBackfillStatsResponse> => {
    await assertAdmin(request.auth?.uid);

    const data = request.data as AdminBackfillStatsRequest | undefined;
    const scope = data?.scope ?? 'all';

    if (scope === 'global' || scope === 'all') {
      const [usersCount, experimentsCount, checkinsCount] = await Promise.all([
        db.collection(USERS).count().get(),
        db.collection(EXPERIMENTS).count().get(),
        db.collectionGroup(CHECKINS).count().get(),
      ]);

      await setGlobalStats({
        totalUsers: usersCount.data().count,
        totalExperiments: experimentsCount.data().count,
        totalCheckins: checkinsCount.data().count,
      });
    }

    if (scope === 'user_experiment_counts' || scope === 'all') {
      let cursor: FirebaseFirestore.QueryDocumentSnapshot<FirebaseFirestore.DocumentData> | null =
        null;
      const pageSize = 100;
      let hasMore = true;

      while (hasMore) {
        let usersQuery = db.collection(USERS).orderBy(FieldPath.documentId()).limit(pageSize);
        if (cursor) {
          usersQuery = usersQuery.startAfter(cursor);
        }

        const usersSnapshot = await usersQuery.get();
        if (usersSnapshot.empty) {
          hasMore = false;
          continue;
        }

        const batch = db.batch();
        for (const userSnapshot of usersSnapshot.docs) {
          const countSnapshot = await db
            .collection(EXPERIMENTS)
            .where('userId', '==', userSnapshot.id)
            .count()
            .get();
          batch.set(
            userSnapshot.ref,
            {
              experimentCount: countSnapshot.data().count,
            },
            { merge: true },
          );
        }

        await batch.commit();
        cursor = usersSnapshot.docs[usersSnapshot.docs.length - 1] ?? null;
        hasMore = usersSnapshot.docs.length === pageSize;
      }
    }

    return {
      ok: true,
      scope,
      updatedAtIso: new Date().toISOString(),
    };
  },
);
