import { logger } from 'firebase-functions';
import { onDocumentUpdated } from 'firebase-functions/v2/firestore';
import { USERS } from './shared/constants';
import { auth } from './shared/firebase';
import type { UserDoc } from './shared/types';

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
    await auth.updateUser(userId, { disabled: true });
  } catch (error) {
    logger.error('Failed to disable auth user', { userId, error });
  }
});
