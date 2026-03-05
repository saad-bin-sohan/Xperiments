# Android Release Setup (Single Firebase Project)

This checklist prepares `apps/mobile` for Android release builds using the
single Firebase project `xperiments-dev`.

## 1) Firebase Console setup (`xperiments-dev`)

1. Open Firebase project `xperiments-dev`.
2. Ensure Android app package is `com.xperiments.app`.
3. Enable Authentication providers:
   - Email/Password
   - Google
4. Confirm SHA fingerprints are added for:
   - Debug keystore
   - Release upload keystore
5. Download the latest Android config and place it at:
   - `apps/mobile/android/app/google-services.json`
6. Ensure `google-services.json` includes a web OAuth client (`client_type: 3`).

## 2) Verify local mobile Firebase config

From `apps/mobile`:

```bash
./tool/check_mobile_firebase_config.sh
```

## 3) Configure release signing

1. Create `apps/mobile/android/key.properties` from
   `apps/mobile/android/key.properties.example`.
2. Fill values for:
   - `storeFile`
   - `storePassword`
   - `keyAlias`
   - `keyPassword`

## 4) Run release readiness checks

From `apps/mobile`:

```bash
./tool/check_release_readiness.sh
```

Legacy alias still works:

```bash
./tool/check_prod_release_readiness.sh
```

## 5) Build release artifacts

From `apps/mobile`:

```bash
flutter build apk --release --dart-define=FLAVOR=dev
flutter build appbundle --release --dart-define=FLAVOR=dev
```

Outputs:

- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`
