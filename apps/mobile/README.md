# Xperiments Mobile

Flutter app for Xperiments (Phase 1 foundation + authentication).

## Requirements

- Flutter 3.41.2+
- Dart 3.11+
- Firebase CLI
- FlutterFire CLI (`dart pub global activate flutterfire_cli`)

## Firebase Setup

Use one Firebase project:

- `xperiments-dev`

In Firebase Console:

1. Add Android app with package name `com.xperiments.app`.
2. Enable Authentication providers:
   - Email/Password
   - Google
3. Create Firestore database.
4. Add Remote Config parameter:
   - `pass_fail_enabled` (default: `false`)
5. Add Android SHA fingerprints in Firebase Console -> Project settings -> Android app:
   - Debug SHA-1: `8C:F1:34:CF:4A:E1:7E:BE:AD:FC:AE:B2:F8:BE:3E:70:7F:A0:FB:3A`
   - Debug SHA-256: `9F:90:2A:4D:45:0A:E4:8B:51:80:8A:C5:33:A6:4A:98:9A:A2:29:0D:68:2F:47:6C:88:7C:08:09:7D:93:21:0D`
   - Release SHA-1: `21:2F:D6:26:6F:F9:4A:B9:0C:22:78:01:2F:0B:C4:F6:9D:31:4A:D6`
   - Release SHA-256: `2A:57:26:4E:9E:65:A3:9C:AF:31:C9:E8:AA:27:A2:60:11:18:64:D4:C2:49:75:8F:59:0A:18:98:4E:19:FB:87`
6. Re-download `google-services.json` after SHA updates.
7. Ensure each Firebase JSON includes a web OAuth client (`oauth_client` with `client_type: 3`).

Generate FlutterFire options:

```bash
flutterfire configure --project=xperiments-dev --platforms=android
```

This updates:

- `lib/core/firebase/firebase_options_dev.dart`
- `android/app/google-services.json`

Validate setup:

```bash
./tool/check_mobile_firebase_config.sh
```

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

## Release build

Release builds require:

- `android/app/google-services.json` (for Firebase + Google Sign-In)
- `android/key.properties` with upload keystore credentials

Then:

```bash
./tool/check_release_readiness.sh
flutter build apk --release --dart-define=FLAVOR=dev
flutter build appbundle --release --dart-define=FLAVOR=dev
```
