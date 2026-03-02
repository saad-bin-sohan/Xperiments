import { useEffect, useState } from 'react';
import { httpsCallable } from 'firebase/functions';
import { functions } from '../../core/firebase';
import type { BasicStats } from '../../core/types';
import { ErrorBlock, LoadingBlock } from '../../components/StateBlocks';
import { SectionCard } from '../../components/SectionCard';

interface AdminBackfillStatsRequest {
  scope: 'global' | 'user_experiment_counts' | 'all';
}

interface AdminBackfillStatsResponse {
  ok: boolean;
  scope: string;
  updatedAtIso: string;
}

const getBasicStatsCallable = httpsCallable<void, BasicStats>(functions, 'adminGetBasicStats');
const backfillStatsCallable = httpsCallable<AdminBackfillStatsRequest, AdminBackfillStatsResponse>(
  functions,
  'adminBackfillStats',
);

export function DashboardPanel() {
  const [stats, setStats] = useState<BasicStats | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const loadStats = async () => {
    setLoading(true);
    setError(null);

    try {
      const response = await getBasicStatsCallable();
      setStats(response.data);
    } catch (loadError) {
      setError(loadError instanceof Error ? loadError.message : 'Failed to load stats.');
      setStats(null);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void loadStats();
  }, []);

  const handleBackfill = async () => {
    if (busy) {
      return;
    }

    setBusy(true);
    setError(null);
    try {
      await backfillStatsCallable({ scope: 'all' });
      await loadStats();
    } catch (backfillError) {
      setError(backfillError instanceof Error ? backfillError.message : 'Failed to recompute stats.');
    } finally {
      setBusy(false);
    }
  };

  return (
    <SectionCard
      title="Basic Stats"
      subtitle="Aggregated counters from Firestore."
      actions={
        <button type="button" onClick={handleBackfill} disabled={busy || loading}>
          {busy ? 'Recomputing...' : 'Recompute Stats'}
        </button>
      }
    >
      {loading ? <LoadingBlock message="Loading stats..." /> : null}
      {!loading && error ? <ErrorBlock message={error} /> : null}
      {!loading && !error && stats ? (
        <div className="stats-grid">
          <article>
            <h3>Total Users</h3>
            <strong>{stats.totalUsers.toLocaleString()}</strong>
          </article>
          <article>
            <h3>Total Experiments</h3>
            <strong>{stats.totalExperiments.toLocaleString()}</strong>
          </article>
          <article>
            <h3>Total Check-ins</h3>
            <strong>{stats.totalCheckins.toLocaleString()}</strong>
          </article>
          <article>
            <h3>Updated</h3>
            <strong>{new Date(stats.updatedAtIso).toLocaleString()}</strong>
          </article>
        </div>
      ) : null}
    </SectionCard>
  );
}
