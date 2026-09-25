# BC64Keys v1.9.2 - Monitor Crash & Keyboard Lag Fix

## What's New

### Stability & performance
- Fixed uncaught AppKit exceptions when the Monitor handled modifier keys (`FlagsChanged`) — `charactersIgnoringModifiers` is only read on keyDown/keyUp
- Reduced keyboard lag: no per-keystroke debug `print` on the remapper hot path; removed `DispatchQueue.sync` around the cached bundle ID
- Monitor stops automatically when leaving the Monitor tab (global key monitor no longer stays on)
- Debug Logging toggle now syncs to the live remapper
- Correct CGEvent pass-through retains (`passUnretained` for original events); remapper start is idempotent

## Download

Choose your preferred format:

### 📦 DMG Installer (Recommended)
**[BC64Keys-v1.9.2.dmg](https://github.com/badcode64/BC64Keys/releases/download/v1.9.2/BC64Keys-v1.9.2.dmg)**
- Professional drag-to-Applications installer
- Easiest installation method

### 📦 ZIP Archive
**[BC64Keys-v1.9.2-notarized.zip](https://github.com/badcode64/BC64Keys/releases/download/v1.9.2/BC64Keys-v1.9.2-notarized.zip)**
- Smaller download size
- Direct app bundle

SHA-256 (GitHub release assets):

```
TBD  BC64Keys-v1.9.2.dmg
TBD  BC64Keys-v1.9.2-notarized.zip
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

### Fixed
- Monitor: `Invalid message sent to event` / uncaught exception on Shift, Cmd, and other modifiers
- Keyboard lag while Monitor was running or Debug Logging printed on every keystroke
- Possible CGEvent retain leak on tap pass-through paths
- Orphan event tap if `startRemapping` was invoked twice without stop

---

## Need Help?

- 📖 [User Guide](https://github.com/badcode64/BC64Keys/blob/main/README.md)
- 🐛 [Report Issues](https://github.com/badcode64/BC64Keys/issues)

---

## Magyar verzió 🇭🇺

# BC64Keys v1.9.2 - Monitor összeomlás és billentyűzet-lag javítás

## Újdonságok

### Stabilitás és teljesítmény
- Javítva: Monitor modifier billentyűknél (`FlagsChanged`) AppKit exception
- Kevesebb lag: nincs billentyűnkénti debug print a remapper hot path-on
- Monitor tab elhagyásakor a figyelés automatikusan leáll
- Debug Logging kapcsoló élőben szinkronizálódik a remapperrel
