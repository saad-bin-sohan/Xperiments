# Xperiments Mobile

Flutter app for Xperiments (Phase 1 foundation + authentication).

## Requirements

- Flutter 3.41.2+
- Dart 3.11+
- Firebase CLI
- FlutterFire CLI (`dart pub global activate flutterfire_cli`)

## Firebase Setup

Use two Firebase projects from day one:

- `xperiments-dev`
- `xperiments-prod`

For each project:

1. Add Android app with package name `com.xperiments.app`.
2. Enable Authentication providers:
   - Email/Password
   - Google
3. Create Firestore database.
4. Add Remote Config parameter:
   - `pass_fail_enabled` (default: `false`)

Generate FlutterFire options per environment:

```bash
flutterfire configure --project=xperiments-dev --platforms=android
flutterfire configure --project=xperiments-prod --platforms=android
```

Then paste generated values into:

- `lib/core/firebase/firebase_options_dev.dart`
- `lib/core/firebase/firebase_options_prod.dart`

```dart
// TODO: iOS Firebase Config — when iOS build begins (~1 week):
// 1. Go to Firebase Console → Project Settings → Add App → iOS
// 2. Download GoogleService-Info.plist and add it to ios/Runner/ via Xcode
// 3. Run: flutterfire configure --platforms=android,ios
```

## Run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run --dart-define=FLAVOR=dev
```
