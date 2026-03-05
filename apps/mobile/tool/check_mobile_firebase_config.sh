#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="$ROOT_DIR/android/app"
FIREBASE_DIR="$ROOT_DIR/lib/core/firebase"

EXPECTED_PROJECT_ID="xperiments-dev"
GOOGLE_SERVICES_JSON="$APP_DIR/google-services.json"
DEV_OPTIONS="$FIREBASE_DIR/firebase_options_dev.dart"

failures=0

pass() {
  echo "[PASS] $1"
}

fail() {
  echo "[FAIL] $1"
  failures=$((failures + 1))
}

json_value() {
  local file="$1"
  local key="$2"
  sed -n "s/.*\"$key\"[[:space:]]*:[[:space:]]*\"\\([^\"]*\\)\".*/\\1/p" "$file" | head -n 1
}

dart_value() {
  local file="$1"
  local key="$2"
  sed -n "s/^[[:space:]]*$key:[[:space:]]*'\\([^']*\\)'.*/\\1/p" "$file" | head -n 1
}

if [[ ! -f "$GOOGLE_SERVICES_JSON" ]]; then
  fail "Missing android/app/google-services.json"
else
  pass "android/app/google-services.json exists"
fi

if [[ ! -f "$DEV_OPTIONS" ]]; then
  fail "Missing lib/core/firebase/firebase_options_dev.dart"
else
  pass "firebase_options_dev.dart exists"
fi

if [[ -f "$GOOGLE_SERVICES_JSON" ]]; then
  project_id="$(json_value "$GOOGLE_SERVICES_JSON" "project_id")"
  if [[ "$project_id" == "$EXPECTED_PROJECT_ID" ]]; then
    pass "google-services.json project_id matches $EXPECTED_PROJECT_ID"
  else
    fail "google-services.json project_id is '$project_id', expected '$EXPECTED_PROJECT_ID'"
  fi

  if grep -Eq '"client_type"[[:space:]]*:[[:space:]]*3' "$GOOGLE_SERVICES_JSON"; then
    pass "google-services.json contains web OAuth client (client_type: 3)"
  else
    fail "google-services.json is missing web OAuth client (client_type: 3)"
  fi
fi

if [[ -f "$GOOGLE_SERVICES_JSON" && -f "$DEV_OPTIONS" ]]; then
  json_api_key="$(json_value "$GOOGLE_SERVICES_JSON" "current_key")"
  json_app_id="$(json_value "$GOOGLE_SERVICES_JSON" "mobilesdk_app_id")"
  json_sender_id="$(json_value "$GOOGLE_SERVICES_JSON" "project_number")"

  options_api_key="$(dart_value "$DEV_OPTIONS" "apiKey")"
  options_app_id="$(dart_value "$DEV_OPTIONS" "appId")"
  options_sender_id="$(dart_value "$DEV_OPTIONS" "messagingSenderId")"
  options_project_id="$(dart_value "$DEV_OPTIONS" "projectId")"

  if [[ -n "$json_api_key" && "$json_api_key" == "$options_api_key" ]]; then
    pass "firebase_options_dev.dart apiKey matches google-services.json"
  else
    fail "firebase_options_dev.dart apiKey does not match google-services.json"
  fi

  if [[ -n "$json_app_id" && "$json_app_id" == "$options_app_id" ]]; then
    pass "firebase_options_dev.dart appId matches google-services.json"
  else
    fail "firebase_options_dev.dart appId does not match google-services.json"
  fi

  if [[ -n "$json_sender_id" && "$json_sender_id" == "$options_sender_id" ]]; then
    pass "firebase_options_dev.dart messagingSenderId matches google-services.json"
  else
    fail "firebase_options_dev.dart messagingSenderId does not match google-services.json"
  fi

  if [[ "$options_project_id" == "$EXPECTED_PROJECT_ID" ]]; then
    pass "firebase_options_dev.dart projectId matches $EXPECTED_PROJECT_ID"
  else
    fail "firebase_options_dev.dart projectId is '$options_project_id', expected '$EXPECTED_PROJECT_ID'"
  fi
fi

if [[ $failures -gt 0 ]]; then
  echo
  echo "Mobile Firebase config check failed: $failures issue(s)."
  exit 1
fi

echo
echo "Mobile Firebase config check passed."
