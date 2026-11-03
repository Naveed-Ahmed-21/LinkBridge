#!/usr/bin/env bash
set -euo pipefail

if [[ -f ".fvmrc" ]]; then
  if ! command -v fvm >/dev/null 2>&1; then
    echo ".fvmrc exists but FVM is not installed."
    exit 1
  fi
  FLUTTER_CMD=(fvm flutter)
  DART_CMD=(fvm dart)
else
  if ! command -v flutter >/dev/null 2>&1; then
    echo "Flutter was not found in PATH. Install Flutter or configure FVM first."
    exit 1
  fi
  FLUTTER_CMD=(flutter)
  DART_CMD=(dart)
fi

echo "Flutter version:"
"${FLUTTER_CMD[@]}" --version

mkdir -p apps packages

create_flutter_app() {
  local target="$1"
  local project="$2"
  local platform="$3"

  if [[ -d "$target" && -f "$target/pubspec.yaml" ]]; then
    echo "Keeping existing Flutter app: $target"
  else
    if [[ -e "$target" ]]; then
      echo "Target $target exists but is not a Flutter app. Move/remove it, then rerun."
      exit 1
    fi
    "${FLUTTER_CMD[@]}" create \
      --org dev.linkbridge \
      --project-name "$project" \
      --platforms="$platform" \
      "$target"
  fi
}

create_dart_package() {
  local target="$1"
  if [[ -d "$target" && -f "$target/pubspec.yaml" ]]; then
    echo "Keeping existing Dart package: $target"
  else
    if [[ -e "$target" ]]; then
      echo "Target $target exists but is not a Dart package. Move/remove it, then rerun."
      exit 1
    fi
    "${DART_CMD[@]}" create --template=package "$target"
  fi
}

create_flutter_app "apps/desktop" "linkbridge_desktop" "linux"
create_flutter_app "apps/mobile" "linkbridge_mobile" "android"

create_dart_package "packages/linkbridge_models"
create_dart_package "packages/linkbridge_protocol"
create_dart_package "packages/linkbridge_core"
create_dart_package "packages/linkbridge_storage"

echo
echo "Bootstrap complete."
echo "Next:"
echo "  1. Review generated pubspec.yaml files."
echo "  2. Add shared package dependencies only when their first API is defined."
echo "  3. Run scripts/verify.sh"
