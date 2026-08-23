# BC64Keys v1.8.0 - Window Switching 🪟

## What's New

### 🪟 Alt+Tab Style Window Switching
New navigation presets for Windows-style app and window switching:
- **Switch App** (⌘Tab) — cycle between applications
- **Switch App (Reverse)** (⇧⌘Tab) — cycle applications backwards
- **Switch Window** (⌘`) — cycle windows of the current app
- **Switch Window (Reverse)** (⇧⌘`) — cycle windows backwards
- Localized in all 14 supported languages

### 🔧 Remapper Reliability
- Unmapped keys now pass through the original event instead of a synthesized replacement
- Caps Lock only remaps when a rule matches; otherwise it toggles normally
- Editing a navigation rule restores the correct preset when several share a key code (e.g. Tab)

## Download

Choose your preferred format:

### 📦 DMG Installer (Recommended)
**[BC64Keys-v1.8.0.dmg](https://github.com/badcode64/BC64Keys/releases/download/v1.8.0/BC64Keys-v1.8.0.dmg)**
- Professional drag-to-Applications installer
- Easiest installation method

### 📦 ZIP Archive
**[BC64Keys-v1.8.0-notarized.zip](https://github.com/badcode64/BC64Keys/releases/download/v1.8.0/BC64Keys-v1.8.0-notarized.zip)**
- Smaller download size
- Direct app bundle

SHA-256 (GitHub release assets):

```
33acca1faf670b305ec16bb5d23c31f4a06f0ed56a9eeddf908b74b82334cdfc  BC64Keys-v1.8.0.dmg
f9078d175a6e8b610ed42175fbe4bab6dcb19c19c147f708ca876fc004db53d8  BC64Keys-v1.8.0-notarized.zip
```

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
- ⌘Tab / ⇧⌘Tab Switch App navigation presets
- ⌘` / ⇧⌘` Switch Window navigation presets
- Localization for the new actions in 14 languages

### Fixed
- Unmapped keys keep the original CGEvent (no synthesized pass-through)
- Caps Lock no longer synthesizes events unless a mapping exists
- Navigation preset picker matches on key code **and** modifiers
- `targetCharacter` is restored when reopening a mapping for edit

---

## Need Help?

- 📖 [User Guide](https://github.com/badcode64/BC64Keys/blob/main/README.md)
- 🐛 [Report Issues](https://github.com/badcode64/BC64Keys/issues)

---

## Magyar verzió 🇭🇺

# BC64Keys v1.8.0 - Ablakváltás 🪟

## Újdonságok

### 🪟 Alt+Tab stílusú ablakváltás
Új navigációs presetek Windows-szerű alkalmazás- és ablakváltáshoz:
- **Alkalmazás váltása** (⌘Tab)
- **Alkalmazás váltása (visszafelé)** (⇧⌘Tab)
- **Ablak váltása** (⌘`)
- **Ablak váltása (visszafelé)** (⇧⌘`)
- Mind a 14 támogatott nyelven

### 🔧 Megbízhatóbb átirányítás
- A nem leképezett billentyűk az eredeti eseményt engedik tovább
- A Caps Lock csak akkor remapeli, ha van rá szabály
- A navigációs preset szerkesztéskor a módosítók alapján is a helyes elemet választja
