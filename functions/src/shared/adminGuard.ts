import { HttpsError } from 'firebase-functions/v2/https';
import { db } from './firebase';
import { USERS } from './constants';
import type { UserDoc } from './types';

export async function assertAdmin(uid: string | undefined): Promise<void> {
  if (!uid) {
    throw new HttpsError('unauthenticated', 'Authentication is required.');
  }

  const userSnapshot = await db.collection(USERS).doc(uid).get();
  if (!userSnapshot.exists) {
    throw new HttpsError('permission-denied', 'Admin access required.');
  }

  const userData = userSnapshot.data() as UserDoc;
  if (userData.isAdmin !== true) {
    throw new HttpsError('permission-denied', 'Admin access required.');
  }
}
