import { onAuthStateChanged, signOut, type User } from 'firebase/auth';
import { doc, getDoc } from 'firebase/firestore';
import { useEffect, useState } from 'react';
import { auth, firestore } from '../../core/firebase';

interface AdminSessionState {
  loading: boolean;
  user: User | null;
  unauthorizedMessage: string | null;
  error: string | null;
}

export function useAdminSession(): AdminSessionState {
  const [state, setState] = useState<AdminSessionState>({
    loading: true,
    user: null,
    unauthorizedMessage: null,
    error: null,
  });

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, async (user) => {
      if (!user) {
        setState((prev) => ({
          loading: false,
          user: null,
          unauthorizedMessage: prev.unauthorizedMessage,
          error: null,
        }));
        return;
      }

      try {
        const userDoc = await getDoc(doc(firestore, 'users', user.uid));
        const isAdmin = userDoc.exists() && userDoc.data().isAdmin === true;

        if (!isAdmin) {
          await signOut(auth);
          setState({
            loading: false,
            user: null,
            unauthorizedMessage: 'Account is not authorized for admin access.',
            error: null,
          });
          return;
        }

        setState({
          loading: false,
          user,
          unauthorizedMessage: null,
          error: null,
        });
      } catch (error) {
        setState({
          loading: false,
          user: null,
          unauthorizedMessage: null,
          error: error instanceof Error ? error.message : 'Failed to verify admin access.',
        });
      }
    });

    return () => unsubscribe();
  }, []);

  return state;
}
