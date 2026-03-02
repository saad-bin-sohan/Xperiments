# Xperiments

Xperiments is a private, minimal self-improvement experiment tracker built with Flutter and Firebase.

## Monorepo Layout

- `apps/mobile`: Flutter mobile app (Android active, iOS onboarding-ready)
- `apps/admin`: Admin panel placeholder (Phase 5)
- `functions`: Firebase Functions placeholder (later phases)
- `firebase`: Shared Firebase config/rules templates

## Phase 1 Setup

1. Install dependencies:
   - `cd apps/mobile`
   - `flutter pub get`
2. Install FlutterFire CLI:
   - `dart pub global activate flutterfire_cli`
3. Add Firebase Android apps for both projects (`xperiments-dev`, `xperiments-prod`) with package: `com.xperiments.app`.
4. Configure FlutterFire for dev:
   - `flutterfire configure --project=xperiments-dev --platforms=android`
   - Copy generated options into `lib/core/firebase/firebase_options_dev.dart`.
5. Configure FlutterFire for prod:
   - `flutterfire configure --project=xperiments-prod --platforms=android`
   - Copy generated options into `lib/core/firebase/firebase_options_prod.dart`.
6. Enable Firebase Auth providers:
   - Email/Password
   - Google
7. Create Firestore database and Remote Config parameter:
   - `pass_fail_enabled` default `false`

```dart
// TODO: iOS Firebase Config — when iOS build begins (~1 week):
// 1. Go to Firebase Console → Project Settings → Add App → iOS
// 2. Download GoogleService-Info.plist and add it to ios/Runner/ via Xcode
// 3. Run: flutterfire configure --platforms=android,ios
```

## Run App

From `apps/mobile`:

- Dev: `flutter run --dart-define=FLAVOR=dev`
- Prod: `flutter run --dart-define=FLAVOR=prod`
