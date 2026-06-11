#!/bin/zsh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/.build/docc"
SITE_DIR="$BUILD_DIR/site"

if [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
  REPOSITORY_NAME="${GITHUB_REPOSITORY#*/}"
else
  REPOSITORY_NAME="$(basename "$ROOT_DIR")"
fi

MODULES=(
  CalendarExtensions
  CalendarKit
  CalendarUI
)

rm -rf "$BUILD_DIR"
mkdir -p "$SITE_DIR"

for MODULE in "${MODULES[@]}"; do
  DERIVED_DATA_PATH="$BUILD_DIR/derived-data/$MODULE"
  OUTPUT_PATH="$SITE_DIR/$MODULE"

  xcodebuild docbuild \
    -scheme "$MODULE" \
    -derivedDataPath "$DERIVED_DATA_PATH" \
    -destination 'generic/platform=iOS'

  ARCHIVE_PATH="$(find "$DERIVED_DATA_PATH" -type d -name "$MODULE.doccarchive" -print -quit)"

  if [[ -z "$ARCHIVE_PATH" ]]; then
    echo "Failed to locate DocC archive for $MODULE" >&2
    exit 1
  fi

  xcrun docc process-archive transform-for-static-hosting \
    "$ARCHIVE_PATH" \
    --output-path "$OUTPUT_PATH" \
    --hosting-base-path "$REPOSITORY_NAME/$MODULE"
done

cat > "$SITE_DIR/index.html" <<EOF
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CalendarKit Documentation</title>
  <style>
    :root {
      color-scheme: light dark;
      --bg: #f6f7fb;
      --card: #ffffff;
      --text: #111827;
      --muted: #4b5563;
      --border: #d1d5db;
      --link: #0f62fe;
    }

    @media (prefers-color-scheme: dark) {
      :root {
        --bg: #111827;
        --card: #1f2937;
        --text: #f9fafb;
        --muted: #cbd5e1;
        --border: #374151;
        --link: #93c5fd;
      }
    }

    body {
      margin: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
      background: var(--bg);
      color: var(--text);
    }

    main {
      max-width: 860px;
      margin: 0 auto;
      padding: 48px 20px 64px;
    }

    h1 {
      margin: 0 0 12px;
      font-size: 2.5rem;
      line-height: 1.1;
    }

    p {
      margin: 0 0 20px;
      color: var(--muted);
      font-size: 1.05rem;
      line-height: 1.6;
    }

    ul {
      list-style: none;
      margin: 32px 0 0;
      padding: 0;
      display: grid;
      gap: 16px;
    }

    a {
      display: block;
      padding: 20px;
      border: 1px solid var(--border);
      border-radius: 14px;
      background: var(--card);
      color: var(--text);
      text-decoration: none;
    }

    a strong {
      display: block;
      margin-bottom: 6px;
      color: var(--link);
      font-size: 1.1rem;
    }

    a span {
      color: var(--muted);
      line-height: 1.5;
    }
  </style>
</head>
<body>
  <main>
    <h1>CalendarKit Documentation</h1>
    <p>Browse the DocC documentation for the Foundation layer, the SwiftUI building blocks, and the higher-level UI package.</p>
    <ul>
      <li>
        <a href="./CalendarExtensions/documentation/calendarextensions/">
          <strong>CalendarExtensions</strong>
          <span>Foundation-first period models, calendar math, and date utilities.</span>
        </a>
      </li>
      <li>
        <a href="./CalendarKit/documentation/calendarkit/">
          <strong>CalendarKit</strong>
          <span>Composable SwiftUI building blocks for custom calendar interfaces.</span>
        </a>
      </li>
      <li>
        <a href="./CalendarUI/documentation/calendarui/">
          <strong>CalendarUI</strong>
          <span>Opinionated UI built on top of CalendarKit.</span>
        </a>
      </li>
    </ul>
  </main>
</body>
</html>
EOF

touch "$SITE_DIR/.nojekyll"

echo "DocC site generated at $SITE_DIR"
