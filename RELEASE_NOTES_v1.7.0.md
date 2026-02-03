# BC64Keys v1.7.0 - Visual Keyboard 🎹

## What's New

### 🎹 Visual Keyboard
A brand new interactive on-screen keyboard for selecting target keys!
- **Click to select** — No need to remember key codes
- **Special characters made easy** — Find `[]`, `{}`, `$`, `@` and other symbols instantly
- **Full keyboard layout** — All keys including function keys and navigation keys
- **Compact design** — Appears on the right side without disrupting the UI

### 🔤 Unicode Character Support
Send actual characters instead of key codes:
- **Layout-independent** — Characters are sent directly, regardless of your keyboard layout
- **Perfect for international users** — No more wrong characters due to layout differences
- **Example**: Pressing `]` always sends `]`, not `Ő` (Hungarian) or other layout-specific characters

### 🔧 Improved Modifier Handling
- **Fixed**: Command+Key → Plain Key mappings now work correctly
- **Example**: `Cmd+R → G` now properly sends `G`, not `Cmd+G`

## Technical Details

### How Unicode Character Sending Works
When you select a key from the visual keyboard, BC64Keys stores both:
1. The key code (for backwards compatibility)
2. The actual Unicode character

When the mapping triggers, it uses `CGEvent.keyboardSetUnicodeString()` to send the actual character, bypassing the keyboard layout entirely.

### Memory & Performance
- Zero memory leaks — proper cleanup in all `deinit` handlers
- Thread-safe mapping access in CGEventTap callback
- Efficient Unicode string handling with UTF-16 conversion

## Download

Choose your preferred format:

### 📦 DMG Installer (Recommended)
**[BC64Keys-v1.7.0.dmg](https://github.com/badcode64/BC64Keys/releases/download/v1.7.0/BC64Keys-v1.7.0.dmg)** (~2.5 MB)
- Professional drag-to-Applications installer
- Easiest installation method

### 📦 ZIP Archive
**[BC64Keys-v1.7.0-notarized.zip](https://github.com/badcode64/BC64Keys/releases/download/v1.7.0/BC64Keys-v1.7.0-notarized.zip)** (~1.7 MB)
- Smaller download size
- Direct app bundle

## Installation

### First-Time Installation
1. Download and open the DMG file
2. Drag **BC64Keys.app** to your **Applications** folder
3. Launch BC64Keys from Applications
4. Grant **Accessibility permissions** when prompted:
   - System Settings → Privacy & Security → Accessibility
   - Add BC64Keys and enable it

### Updating from Previous Version
Simply replace the old app with the new one. Your settings and key mappings are preserved.

## System Requirements
- macOS 13.0 (Ventura) or later
- Universal Binary: Apple Silicon (M1/M2/M3/M4) and Intel Macs

## Full Changelog

### Added
- Visual Keyboard for easy target key selection
- `targetCharacter` field in KeyMappingRule for Unicode support
- `keyboardSetUnicodeString()` support for sending actual characters
- Show/Hide Keyboard toggle in Add Mapping sheet
- Compact keyboard layout with function keys and navigation keys

### Fixed
- Command+modifier → plain key mappings now clear modifiers correctly
- Visual keyboard selections now send correct characters regardless of system keyboard layout

### Technical
- New `VisualKeyboardView` component (~150 lines)
- New `CompactKeyButton` component
- Updated `KeyMappingRule` with `targetCharacter: String?` field
- Enhanced `handleKeyMapping()` with Unicode character injection
- Dynamic window width (500px → 920px when keyboard visible)

---

## Need Help?

- 📖 [User Guide](https://github.com/badcode64/BC64Keys/blob/main/README.md)
- 🐛 [Report Issues](https://github.com/badcode64/BC64Keys/issues)
- 💬 [Discussions](https://github.com/badcode64/BC64Keys/discussions)

---

## Magyar verzió 🇭🇺

# BC64Keys v1.7.0 - Vizuális billentyűzet 🎹

## Újdonságok

### 🎹 Vizuális billentyűzet
Új interaktív képernyő-billentyűzet a célbillentyűk kiválasztásához!
- **Kattintással kiválasztható** — Nem kell megjegyezni a billentyűkódokat
- **Speciális karakterek egyszerűen** — Azonnal megtalálod a `[]`, `{}`, `$`, `@` és más szimbólumokat
- **Teljes billentyűzetkiosztás** — Minden billentyű, beleértve a funkcióbillentyűket és navigációs gombokat
- **Kompakt dizájn** — Jobb oldalon jelenik meg, nem zavarja a felületet

### 🔤 Unicode karakter támogatás
A tényleges karakterek küldése billentyűkódok helyett:
- **Kiosztás-független** — A karakterek közvetlenül kerülnek elküldésre, függetlenül a billentyűzetkiosztástól
- **Tökéletes nemzetközi felhasználóknak** — Többé nincs rossz karakter a kiosztás különbségei miatt
- **Példa**: A `]` lenyomása mindig `]`-t küld, nem `Ő`-t (magyar kiosztáson)

### 🔧 Javított módosítóbillentyű-kezelés
- **Javítva**: Command+Billentyű → Sima billentyű leképezések most helyesen működnek
- **Példa**: `Cmd+R → G` most helyesen küld `G`-t, nem `Cmd+G`-t
