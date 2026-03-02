import { GLOBAL_STATS_DOC, STATS, type StatsField } from './constants';
import { admin, db } from './firebase';
import type { StatsDoc } from './types';

const statsRef = db.collection(STATS).doc(GLOBAL_STATS_DOC);

export async function incrementGlobalCounter(field: StatsField, delta: number): Promise<void> {
  if (delta === 0) {
    return;
  }

  if (delta > 0) {
    await statsRef.set(
      {
        [field]: admin.firestore.FieldValue.increment(delta),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );
    return;
  }

  await db.runTransaction(async (transaction) => {
    const snapshot = await transaction.get(statsRef);
    const data = (snapshot.data() ?? {}) as StatsDoc;
    const current = Number((data as Record<string, unknown>)[field] ?? 0);
    const next = Math.max(0, current + delta);

    transaction.set(
      statsRef,
      {
        [field]: next,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );
  });
}

export async function setGlobalStats(stats: {
  totalUsers: number;
  totalExperiments: number;
  totalCheckins: number;
}): Promise<void> {
  await statsRef.set(
    {
      totalUsers: Math.max(0, stats.totalUsers),
      totalExperiments: Math.max(0, stats.totalExperiments),
      totalCheckins: Math.max(0, stats.totalCheckins),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    },
    { merge: true },
  );
}

export async function readGlobalStats(): Promise<{
  totalUsers: number;
  totalExperiments: number;
  totalCheckins: number;
  updatedAtIso: string;
}> {
  const snapshot = await statsRef.get();
  if (!snapshot.exists) {
    return {
      totalUsers: 0,
      totalExperiments: 0,
      totalCheckins: 0,
      updatedAtIso: new Date().toISOString(),
    };
  }

  const data = snapshot.data() as StatsDoc;

  return {
    totalUsers: Number(data.totalUsers ?? 0),
    totalExperiments: Number(data.totalExperiments ?? 0),
    totalCheckins: Number(data.totalCheckins ?? 0),
    updatedAtIso: data.updatedAt?.toDate().toISOString() ?? new Date().toISOString(),
  };
}
