#!/bin/bash

set -e

BUNDLE_NAME="German_NoDeadKeys.bundle"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE="$SCRIPT_DIR/$BUNDLE_NAME"
DEST_DIR="$HOME/Library/Keyboard Layouts"
DEST="$DEST_DIR/$BUNDLE_NAME"

LAYOUT_NAME="German - No Dead Keys"
LAYOUT_ID=-5099
PLIST="$HOME/Library/Preferences/com.apple.HIToolbox.plist"

if [ ! -d "$SOURCE" ]; then
	echo "Error: $BUNDLE_NAME not found in $SCRIPT_DIR"
	exit 1
fi

mkdir -p "$DEST_DIR"

echo "Installing $BUNDLE_NAME..."
cp -R "$SOURCE" "$DEST_DIR/"

# Remove quarantine attribute that macOS adds to files downloaded from the web
xattr -dr com.apple.quarantine "$DEST" 2>/dev/null || true

# Add layout to HIToolbox enabled input sources if not already present
if defaults read com.apple.HIToolbox AppleEnabledInputSources 2>/dev/null | grep -q "$LAYOUT_NAME"; then
	echo "Layout already registered in HIToolbox."
else
	if [ -f "$PLIST" ]; then
		COUNT=$(/usr/libexec/PlistBuddy -c "Print :AppleEnabledInputSources" "$PLIST" 2>/dev/null | grep -c "Dict" || echo "0")
		/usr/libexec/PlistBuddy \
			-c "Add :AppleEnabledInputSources:$COUNT dict" \
			-c "Add :AppleEnabledInputSources:$COUNT:InputSourceKind string 'Keyboard Layout'" \
			-c "Add :AppleEnabledInputSources:$COUNT:KeyboardLayout\ ID integer $LAYOUT_ID" \
			-c "Add :AppleEnabledInputSources:$COUNT:KeyboardLayout\ Name string '$LAYOUT_NAME'" \
			"$PLIST"
		echo "Layout added to enabled input sources."
	else
		echo "Warning: $PLIST not found. Skipping input source registration."
		echo "You may need to manually add the layout in System Settings > Keyboard > Input Sources."
	fi
fi

echo "Done. Please log out and log back in. Then, select '$LAYOUT_NAME' in System Settings > Keyboard > Input Sources and we are good to go. Have fun!"
