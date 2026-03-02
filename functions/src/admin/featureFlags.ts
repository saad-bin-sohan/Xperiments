import { HttpsError, onCall } from 'firebase-functions/v2/https';
import { PASS_FAIL_PARAMETER_KEY } from '../shared/constants';
import { remoteConfig } from '../shared/firebase';
import { assertAdmin } from '../shared/adminGuard';

interface FeatureFlagsResponse {
  passFailEnabled: boolean;
  fetchedAtIso?: string;
  updatedAtIso?: string;
}

interface SetPassFailFlagRequest {
  enabled: boolean;
}

function toBool(raw: string | undefined): boolean {
  return String(raw ?? '').toLowerCase() === 'true';
}

export const adminGetFeatureFlags = onCall(async (request): Promise<FeatureFlagsResponse> => {
  await assertAdmin(request.auth?.uid);

  const template = await remoteConfig.getTemplate();
  const parameter = template.parameters[PASS_FAIL_PARAMETER_KEY];
  const defaultValue = parameter?.defaultValue as { value?: string } | undefined;
  const passFailEnabled = toBool(defaultValue?.value);

  return {
    passFailEnabled,
    fetchedAtIso: new Date().toISOString(),
  };
});

export const adminSetPassFailFlag = onCall(async (request): Promise<FeatureFlagsResponse> => {
    await assertAdmin(request.auth?.uid);

    const data = request.data as SetPassFailFlagRequest | undefined;
    const enabled = data?.enabled;
    if (typeof enabled !== 'boolean') {
      throw new HttpsError('invalid-argument', 'enabled must be a boolean.');
    }

    const template = await remoteConfig.getTemplate();
    const existing = template.parameters[PASS_FAIL_PARAMETER_KEY];

    template.parameters[PASS_FAIL_PARAMETER_KEY] = {
      defaultValue: { value: enabled ? 'true' : 'false' },
      description:
        existing?.description || 'Controls pass/fail UI visibility for experiments',
      valueType: existing?.valueType,
    };

    const validatedTemplate = await remoteConfig.validateTemplate(template);
    await remoteConfig.publishTemplate(validatedTemplate);

    return {
      passFailEnabled: enabled,
      updatedAtIso: new Date().toISOString(),
    };
});
