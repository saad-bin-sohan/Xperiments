import { onDocumentCreated, onDocumentDeleted } from 'firebase-functions/v2/firestore';
import { EXPERIMENTS, USERS } from '../shared/constants';
import { admin, db } from '../shared/firebase';
import { incrementGlobalCounter } from '../shared/counters';
import type { ExperimentDoc } from '../shared/types';

export const onUserDocumentCreate = onDocumentCreated(`${USERS}/{userId}`, async (event) => {
  const userId = event.params.userId;

  await Promise.all([
    incrementGlobalCounter('totalUsers', 1),
    db
      .collection(USERS)
      .doc(userId)
      .set({ experimentCount: 0 }, { merge: true }),
  ]);
});

export const onExperimentCreate = onDocumentCreated(`${EXPERIMENTS}/{experimentId}`, async (event) => {
  const data = event.data?.data() as ExperimentDoc | undefined;
  const userId = data?.userId;
  if (!userId) {
    return;
  }

  await Promise.all([
    incrementGlobalCounter('totalExperiments', 1),
    db
      .collection(USERS)
      .doc(userId)
      .set(
        {
          experimentCount: admin.firestore.FieldValue.increment(1),
        },
        { merge: true },
      ),
  ]);
});

export const onExperimentDelete = onDocumentDeleted(`${EXPERIMENTS}/{experimentId}`, async (event) => {
  const data = event.data?.data() as ExperimentDoc | undefined;
  const userId = data?.userId;
  if (!userId) {
    await incrementGlobalCounter('totalExperiments', -1);
    return;
  }

  await incrementGlobalCounter('totalExperiments', -1);

  const userRef = db.collection(USERS).doc(userId);
  await db.runTransaction(async (transaction) => {
    const snapshot = await transaction.get(userRef);
    const current = Number(snapshot.data()?.experimentCount ?? 0);
    transaction.set(
      userRef,
      {
        experimentCount: Math.max(0, current - 1),
      },
      { merge: true },
    );
  });
});
