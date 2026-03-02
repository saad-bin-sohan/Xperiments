import { useEffect, useState } from 'react';
import { httpsCallable } from 'firebase/functions';
import { functions } from '../../core/firebase';
import type { FeatureFlagsState } from '../../core/types';
import { ErrorBlock, LoadingBlock } from '../../components/StateBlocks';
import { SectionCard } from '../../components/SectionCard';

interface FeatureFlagsResponse {
  passFailEnabled: boolean;
  fetchedAtIso?: string;
  updatedAtIso?: string;
}

interface SetPassFailFlagRequest {
  enabled: boolean;
}

const getFeatureFlagsCallable = httpsCallable<void, FeatureFlagsResponse>(
  functions,
  'adminGetFeatureFlags',
);
const setPassFailFlagCallable = httpsCallable<SetPassFailFlagRequest, FeatureFlagsResponse>(
  functions,
  'adminSetPassFailFlag',
);

export function FeatureFlagsPanel() {
  const [state, setState] = useState<FeatureFlagsState>({
    passFailEnabled: false,
    loading: true,
    error: null,
  });
  const [lastUpdatedAt, setLastUpdatedAt] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);

  const loadFlags = async () => {
    setState((prev) => ({ ...prev, loading: true, error: null }));
    try {
      const response = await getFeatureFlagsCallable();
      setState({
        passFailEnabled: response.data.passFailEnabled,
        loading: false,
        error: null,
      });
      setLastUpdatedAt(response.data.fetchedAtIso ?? null);
    } catch (error) {
      setState((prev) => ({
        ...prev,
        loading: false,
        error: error instanceof Error ? error.message : 'Failed to load feature flags.',
      }));
    }
  };

  useEffect(() => {
    void loadFlags();
  }, []);

  const onToggle = async (nextValue: boolean) => {
    if (saving) {
      return;
    }

    setSaving(true);
    setState((prev) => ({ ...prev, error: null }));

    try {
      const response = await setPassFailFlagCallable({ enabled: nextValue });
      setState({
        passFailEnabled: response.data.passFailEnabled,
        loading: false,
        error: null,
      });
      setLastUpdatedAt(response.data.updatedAtIso ?? null);
    } catch (error) {
      setState((prev) => ({
        ...prev,
        error: error instanceof Error ? error.message : 'Failed to update feature flag.',
      }));
    } finally {
      setSaving(false);
    }
  };

  return (
    <SectionCard title="Feature Flags" subtitle="Remote Config managed from admin callables.">
      {state.loading ? <LoadingBlock message="Loading feature flags..." /> : null}
      {!state.loading && state.error ? <ErrorBlock message={state.error} /> : null}
      {!state.loading && !state.error ? (
        <div className="flag-row">
          <label htmlFor="pass-fail-toggle">Pass/Fail feature (`pass_fail_enabled`)</label>
          <input
            id="pass-fail-toggle"
            type="checkbox"
            checked={state.passFailEnabled}
            disabled={saving}
            onChange={(event) => {
              void onToggle(event.target.checked);
            }}
          />
        </div>
      ) : null}
      {lastUpdatedAt ? <p className="muted">Last sync: {new Date(lastUpdatedAt).toLocaleString()}</p> : null}
    </SectionCard>
  );
}
