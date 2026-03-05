#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="$ROOT_DIR/android/app"
KEY_PROPERTIES="$ROOT_DIR/android/key.properties"
DEV_OPTIONS="$ROOT_DIR/lib/core/firebase/firebase_options_dev.dart"
MOBILE_CONFIG_CHECKER="$ROOT_DIR/tool/check_mobile_firebase_config.sh"

failures=0

pass() {
  echo "[PASS] $1"
}

fail() {
  echo "[FAIL] $1"
  failures=$((failures + 1))
}

info() {
  echo "[INFO] $1"
}

if [[ -f "$APP_DIR/google-services.json" ]]; then
  pass "android/app/google-services.json exists"
else
  fail "android/app/google-services.json is missing"
fi

if [[ -x "$MOBILE_CONFIG_CHECKER" ]]; then
  if "$MOBILE_CONFIG_CHECKER"; then
    pass "Mobile Firebase config checker passed"
  else
    fail "Mobile Firebase config checker failed"
  fi
else
  fail "tool/check_mobile_firebase_config.sh is missing or not executable"
fi

if [[ -f "$KEY_PROPERTIES" ]]; then
  required_keys=("storeFile" "storePassword" "keyAlias" "keyPassword")
  for key in "${required_keys[@]}"; do
    value="$(grep -E "^${key}=" "$KEY_PROPERTIES" | head -n 1 | cut -d'=' -f2- || true)"
    if [[ -n "${value// }" ]]; then
      pass "android/key.properties has $key"
    else
      fail "android/key.properties is missing a non-empty $key"
    fi
  done
else
  fail "android/key.properties is missing"
fi

android_options_block="$(sed -n '/static const FirebaseOptions android = FirebaseOptions(/,/);/p' "$DEV_OPTIONS")"
if echo "$android_options_block" | grep -q "DEV_ANDROID_API_KEY" || \
  echo "$android_options_block" | grep -q "1:000000000000:android:dev000000000000" || \
  echo "$android_options_block" | grep -q "messagingSenderId: '000000000000'"; then
  fail "firebase_options_dev.dart still appears to contain placeholder values"
else
  pass "firebase_options_dev.dart does not contain known placeholder values"
fi

if command -v firebase >/dev/null 2>&1; then
  if firebase projects:list --json 2>/dev/null | grep -q '"projectId": "xperiments-dev"'; then
    pass "firebase CLI account has access to xperiments-dev"
  else
    fail "firebase CLI account does not have access to xperiments-dev"
  fi
else
  info "firebase CLI is not installed; skipping project access check"
fi

if [[ $failures -gt 0 ]]; then
  echo
  echo "Readiness check failed: $failures issue(s) found."
  exit 1
fi

echo
echo "Readiness check passed."
