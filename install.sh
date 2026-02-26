#!/bin/bash

set -e

BUNDLE_NAME="German_NoDeadKeys.bundle"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE="$SCRIPT_DIR/$BUNDLE_NAME"
DEST_DIR="$HOME/Library/Keyboard Layouts"
DEST="$DEST_DIR/$BUNDLE_NAME"

if [ ! -d "$SOURCE" ]; then
  echo "Error: $BUNDLE_NAME not found in $SCRIPT_DIR"
  exit 1
fi

mkdir -p "$DEST_DIR"

echo "Installing $BUNDLE_NAME..."
cp -R "$SOURCE" "$DEST_DIR/"

# Remove quarantine attribute that macOS adds to files downloaded from the web
xattr -dr com.apple.quarantine "$DEST" 2>/dev/null || true

echo "Done. Please reboot and then select 'German - No Dead Keys' in System Settings > Keyboard > Input Sources."
