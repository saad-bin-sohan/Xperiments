import {
  collection,
  getDocs,
  limit,
  orderBy,
  query,
  startAfter,
  updateDoc,
  doc,
  type DocumentData,
  type QueryDocumentSnapshot,
} from 'firebase/firestore';
import { useEffect, useMemo, useState } from 'react';
import { firestore } from '../../core/firebase';
import type { AdminUserRow } from '../../core/types';
import { EmptyBlock, ErrorBlock, LoadingBlock } from '../../components/StateBlocks';
import { SectionCard } from '../../components/SectionCard';

const PAGE_SIZE = 25;

function toUserRow(docSnap: QueryDocumentSnapshot<DocumentData>): AdminUserRow {
  const data = docSnap.data();
  return {
    id: docSnap.id,
    email: String(data.email ?? ''),
    displayName: String(data.displayName ?? ''),
    createdAt: data.createdAt ?? null,
    disabled: data.disabled === true,
    isAdmin: data.isAdmin === true,
    experimentCount: Number(data.experimentCount ?? 0),
  };
}

export function UserManagerPanel() {
  const [users, setUsers] = useState<AdminUserRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [pageIndex, setPageIndex] = useState(0);
  const [hasNextPage, setHasNextPage] = useState(false);
  const [disablingId, setDisablingId] = useState<string | null>(null);
  const [cursors, setCursors] = useState<Array<QueryDocumentSnapshot<DocumentData> | null>>([null]);

  const usersCollection = useMemo(() => collection(firestore, 'users'), []);

  const loadPage = async (index: number) => {
    setLoading(true);
    setError(null);

    try {
      const cursor = cursors[index];
      let baseQuery = query(usersCollection, orderBy('createdAt', 'desc'), limit(PAGE_SIZE + 1));
      if (cursor) {
        baseQuery = query(
          usersCollection,
          orderBy('createdAt', 'desc'),
          startAfter(cursor),
          limit(PAGE_SIZE + 1),
        );
      }

      const snapshot = await getDocs(baseQuery);
      const hasExtra = snapshot.docs.length > PAGE_SIZE;
      const pageDocs = hasExtra ? snapshot.docs.slice(0, PAGE_SIZE) : snapshot.docs;

      setUsers(pageDocs.map(toUserRow));
      setHasNextPage(hasExtra);
      setPageIndex(index);

      if (hasExtra && pageDocs.length > 0) {
        const nextCursor = pageDocs[pageDocs.length - 1];
        setCursors((prev) => {
          const next = [...prev];
          next[index + 1] = nextCursor;
          return next;
        });
      }
    } catch (loadError) {
      setError(loadError instanceof Error ? loadError.message : 'Failed to load users.');
      setUsers([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void loadPage(0);
  }, []);

  const disableUser = async (userId: string) => {
    if (disablingId) {
      return;
    }

    const confirmed = window.confirm('Deactivate this user account?');
    if (!confirmed) {
      return;
    }

    setDisablingId(userId);
    setError(null);

    try {
      await updateDoc(doc(firestore, 'users', userId), { disabled: true });
      await loadPage(pageIndex);
    } catch (disableError) {
      setError(disableError instanceof Error ? disableError.message : 'Failed to deactivate user.');
    } finally {
      setDisablingId(null);
    }
  };

  return (
    <SectionCard title="User Manager" subtitle="View users and deactivate accounts.">
      {loading ? <LoadingBlock message="Loading users..." /> : null}
      {!loading && error ? <ErrorBlock message={error} /> : null}
      {!loading && !error && users.length === 0 ? <EmptyBlock message="No users found." /> : null}
      {!loading && !error && users.length > 0 ? (
        <div className="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Email</th>
                <th>Name</th>
                <th>Joined</th>
                <th>Experiments</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {users.map((user) => (
                <tr key={user.id}>
                  <td>{user.email}</td>
                  <td>{user.displayName || '-'}</td>
                  <td>{user.createdAt?.toDate ? user.createdAt.toDate().toLocaleDateString() : '-'}</td>
                  <td>{user.experimentCount}</td>
                  <td>
                    {user.disabled ? 'Disabled' : 'Active'}
                    {user.isAdmin ? ' · Admin' : ''}
                  </td>
                  <td>
                    <button
                      type="button"
                      className="danger"
                      disabled={user.disabled || disablingId === user.id}
                      onClick={() => {
                        void disableUser(user.id);
                      }}
                    >
                      {disablingId === user.id ? 'Saving...' : 'Deactivate'}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ) : null}
      <div className="pagination-row">
        <button
          type="button"
          disabled={pageIndex === 0 || loading}
          onClick={() => {
            void loadPage(pageIndex - 1);
          }}
        >
          Previous
        </button>
        <span className="muted">Page {pageIndex + 1}</span>
        <button
          type="button"
          disabled={!hasNextPage || loading}
          onClick={() => {
            void loadPage(pageIndex + 1);
          }}
        >
          Next
        </button>
      </div>
    </SectionCard>
  );
}
