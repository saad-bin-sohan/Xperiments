# Xperiments

Xperiments is a private, minimal self-improvement experiment tracker built with Flutter + Firebase.

## Try the app (instant preview)

You can test the Android app instantly in your browser (no install required):

👉 https://appetize.io/app/b_3q5obu3u4olpvt7dljnh4zovri

> Note: This is a live emulator preview and may take a few seconds to load.

## Monorepo layout

- `apps/mobile` Flutter mobile app (Android active, iOS-ready architecture)
- `apps/admin` Admin panel (React + Vite + TypeScript)
- `functions` Firebase Cloud Functions (TypeScript)
- `firebase` Canonical Firebase rules/indexes/templates

## Prerequisites

- Flutter `3.41.2+`
- Dart `3.11+`
- Node.js `20.x` (for functions runtime parity)
- npm `10+`
- Firebase CLI (`firebase-tools`)
- FlutterFire CLI (`dart pub global activate flutterfire_cli`)

## Firebase projects and aliases

Current setup uses one Firebase project:

- `xperiments-dev`

Root `.firebaserc` maps aliases:

- `dev -> xperiments-dev`

## One-time Firebase setup

1. Enable Authentication providers:
   - Email/Password
   - Google
2. Create Firestore database (production mode).
3. (Optional) Create Firebase Storage bucket when you are ready to enable cloud photo uploads.
4. Create Remote Config parameter:
   - `pass_fail_enabled` default `false`
5. Register Android app with package `com.xperiments.app`.
6. Register a Firebase Web app for `apps/admin` and store config values.

## Mobile app setup (`apps/mobile`)

1. Install dependencies:

```bash
cd apps/mobile
flutter pub get
```

2. Generate FlutterFire options and update:

- `lib/core/firebase/firebase_options_dev.dart`
- `android/app/google-services.json`

```bash
flutterfire configure --project=xperiments-dev --platforms=android
```

3. Generate Riverpod/Freezed files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run:

```bash
flutter run --dart-define=FLAVOR=dev
```

## Build Android release APK

From `apps/mobile`:

1. Configure upload signing:

```bash
cp android/key.properties.example android/key.properties
```

Then set real keystore values in `android/key.properties`.

2. Build:

```bash
./tool/check_release_readiness.sh
flutter build apk --release --dart-define=FLAVOR=dev
```

APK output:

- `apps/mobile/build/app/outputs/flutter-apk/app-release.apk`

## Admin panel setup (`apps/admin`)

1. Create env file:

```bash
cd apps/admin
cp .env.example .env.local
```

2. Set values in `.env.local`:

- `VITE_FIREBASE_API_KEY`
- `VITE_FIREBASE_AUTH_DOMAIN`
- `VITE_FIREBASE_PROJECT_ID`
- `VITE_FIREBASE_STORAGE_BUCKET`
- `VITE_FIREBASE_MESSAGING_SENDER_ID`
- `VITE_FIREBASE_APP_ID`
- `VITE_FIREBASE_FUNCTIONS_REGION` (default `us-central1`)

3. Install and run:

```bash
npm install
npm run dev
```

4. Build:

```bash
npm run build
```

## Functions setup (`functions`)

```bash
cd functions
npm install
npm run build
npm run lint
```

## Deploying backend + hosting

From repo root:

```bash
firebase deploy --project dev --only hosting,functions,firestore
```

Deploy specific targets:

```bash
firebase deploy --project dev --only hosting:admin
firebase deploy --project dev --only functions
firebase deploy --project dev --only firestore:rules,firestore:indexes
```

## Rules and indexes

Canonical Firebase config lives in:

- `firebase/firestore.rules`
- `firebase/firestore.indexes.json`
- `firebase/storage.rules`

`apps/mobile` contains mirrored copies used by local mobile tooling.

## Admin operations

### Create first admin account

1. Sign in once through admin login (or mobile auth flow) so user doc exists.
2. In Firestore set:

- `users/{uid}.isAdmin = true`

### Deactivate a user

Use Admin -> User Manager -> `Deactivate`. This sets `users/{uid}.disabled = true`.
`onUserDisabled` then disables the Firebase Auth account.

### Manage gallery templates

Use Admin -> Gallery Manager for create/edit/delete/feature/order operations.

### Toggle pass/fail feature flag

Use Admin -> Feature Flags to update Remote Config `pass_fail_enabled`.

### Recompute stats counters

Use Admin -> Dashboard -> `Recompute Stats`.
This calls `adminBackfillStats` to refresh aggregated counters.

## Troubleshooting

- `permission-denied` in admin app: ensure current user doc has `isAdmin: true`.
- Feature flag not changing in mobile immediately: Remote Config uses fetch interval caching.
- Function deploy errors for runtime: ensure Node 20 is used in local environment and CI.
- Firestore index errors: deploy indexes with `firebase deploy --only firestore:indexes`.

## iOS Onboarding Checklist

1. Run FlutterFire configure for both platforms:

```bash
flutterfire configure --platforms=android,ios
```

2. Add `GoogleService-Info.plist` to `ios/Runner/` using Xcode (drag into Runner target).
3. In Firebase Console, enable Apple Sign-In provider and implement the existing auth TODO:

```dart
// TODO: Apple Sign-In — implement when iOS build begins
```

4. Set iOS deployment target to `16.0` in Xcode project settings and `ios/Podfile`.
5. Configure WidgetKit extension for the home widget using the Phase 4 TODO guidance:
   - Create WidgetKit extension target
   - Implement AppIntent tap-to-checkin handling
   - Wire `home_widget` iOS UserDefaults channel
6. Confirm bundle identifier matches `com.xperiments.app`.
7. Build/archive for TestFlight, upload in Xcode Organizer, then submit to App Store review.
