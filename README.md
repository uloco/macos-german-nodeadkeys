# macos-german-nodeadkeys

German keyboard layout without dead keys

## Installing

### Using the install script (recommended)

```bash
git clone https://github.com/uloco/macos-german-nodeadkeys.git
cd macos-german-nodeadkeys
./install.sh
```

Then reboot and select _German - No Dead Keys_ in System Settings > Keyboard > Input Sources.

### Manual installation

1. Download `German_NoDeadKeys.bundle`
2. Copy it into `~/Library/Keyboard Layouts/`
3. Remove the quarantine attribute (required on macOS Sequoia and later):
   ```bash
   xattr -dr com.apple.quarantine ~/Library/Keyboard\ Layouts/German_NoDeadKeys.bundle
   ```
4. Reboot
5. Open System Settings and select _German - No Dead Keys_

> **Note:** Since macOS Sequoia (15), Apple blocks unsigned/unnotarized bundles that
> carry a quarantine attribute. Keyboard layout bundles are loaded silently by the
> system — there is no Gatekeeper prompt to approve them — so they just fail to work.
> Removing the quarantine attribute (step 3) is required to fix this.

## Optional

You cannot remove the standard german layout from the system preferences menu
but there is another way.

1. `open ~/Library/Preferences/com.apple.HIToolbox.plist`
2. Remove it from the _AppleEnabledInputSources_ entry
3. Reboot


Have fun! :)
