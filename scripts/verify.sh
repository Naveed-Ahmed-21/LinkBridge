#!/usr/bin/env bash
set -euo pipefail

if [[ -f ".fvmrc" ]]; then
  if command -v fvm >/dev/null 2>&1; then
    FLUTTER_CMD=(fvm flutter)
    DART_CMD=(fvm dart)
  else
    if ! command -v flutter >/dev/null 2>&1; then
      echo ".fvmrc exists but neither FVM nor Flutter was found in PATH."
      exit 1
    fi
    echo "Warning: .fvmrc exists but FVM is not installed. Falling back to Flutter in PATH."
    FLUTTER_CMD=(flutter)
    DART_CMD=(dart)
  fi
else
  if ! command -v flutter >/dev/null 2>&1; then
    echo "Flutter was not found in PATH."
    exit 1
  fi
  FLUTTER_CMD=(flutter)
  DART_CMD=(dart)
fi

targets=(
  "apps/desktop"
  "apps/mobile"
  "packages/linkbridge_models"
  "packages/linkbridge_protocol"
  "packages/linkbridge_core"
  "packages/linkbridge_storage"
)

for target in "${targets[@]}"; do
  if [[ ! -f "$target/pubspec.yaml" ]]; then
    echo "Missing $target/pubspec.yaml. Run ./scripts/bootstrap.sh first."
    exit 1
  fi

  echo
  echo "=== $target ==="
  (
    cd "$target"
    "${FLUTTER_CMD[@]}" pub get
    "${DART_CMD[@]}" format --output=none --set-exit-if-changed .
    "${FLUTTER_CMD[@]}" analyze
    "${FLUTTER_CMD[@]}" test
  )
done

echo
echo "All configured Flutter targets passed verification."
