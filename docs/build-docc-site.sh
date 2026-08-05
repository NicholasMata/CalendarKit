#!/bin/zsh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/.build/docc"
SITE_DIR="$BUILD_DIR/site"
COMBINED_ARCHIVE="$BUILD_DIR/CalendarKit.doccarchive"

if [[ -v DOCC_HOSTING_BASE_PATH ]]; then
  HOSTING_BASE_PATH="$DOCC_HOSTING_BASE_PATH"
elif [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
  HOSTING_BASE_PATH="${GITHUB_REPOSITORY#*/}"
else
  HOSTING_BASE_PATH="$(basename "$ROOT_DIR")"
fi

MODULES=(
  CalendarExtensions
  CalendarKit
  CalendarUI
)

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

ARCHIVES=()

for MODULE in "${MODULES[@]}"; do
  DERIVED_DATA_PATH="$BUILD_DIR/derived-data/$MODULE"

  xcodebuild docbuild \
    -quiet \
    -scheme "$MODULE" \
    -derivedDataPath "$DERIVED_DATA_PATH" \
    -destination 'generic/platform=iOS' \
    OTHER_DOCC_FLAGS="--warnings-as-errors"

  ARCHIVE_PATH="$(find "$DERIVED_DATA_PATH" -type d -name "$MODULE.doccarchive" -print -quit)"

  if [[ -z "$ARCHIVE_PATH" ]]; then
    echo "Failed to locate DocC archive for $MODULE" >&2
    exit 1
  fi

  ARCHIVES+=("$ARCHIVE_PATH")
done

xcrun docc merge \
  "${ARCHIVES[@]}" \
  --output-path "$COMBINED_ARCHIVE" \
  --synthesized-landing-page-name "CalendarKit" \
  --synthesized-landing-page-kind "Package" \
  --synthesized-landing-page-topics-style detailedGrid

HOSTING_ARGUMENTS=()
if [[ -n "$HOSTING_BASE_PATH" ]]; then
  HOSTING_ARGUMENTS=(--hosting-base-path "$HOSTING_BASE_PATH")
fi

xcrun docc process-archive transform-for-static-hosting \
  "$COMBINED_ARCHIVE" \
  --output-path "$SITE_DIR" \
  "${HOSTING_ARGUMENTS[@]}"

LANDING_PAGE_DATA="$SITE_DIR/data/documentation.json"
if ! grep -q '"type"[[:space:]]*:[[:space:]]*"image"' "$LANDING_PAGE_DATA"; then
  echo "Merged DocC landing page is missing image resources" >&2
  exit 1
fi

touch "$SITE_DIR/.nojekyll"

echo "DocC site generated at $SITE_DIR"
