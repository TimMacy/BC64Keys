#!/bin/bash

# BC64Keys Build Script - Clean build
echo "🧹 Cleaning old builds..."
rm -rf BC64Keys BC64Keys.app BC64Keys.dSYM 2>/dev/null

echo "🔨 Building BC64Keys..."

# Build for both ARM64 (Apple Silicon) and x86_64 (Intel)
echo "  - Building for ARM64 (Apple Silicon)..."
swiftc Sources/BC64Keys/Localization.swift \
    Sources/BC64Keys/BC64KeysApp.swift \
    -o BC64Keys_arm64 \
    -framework SwiftUI \
    -framework AppKit \
    -framework Carbon \
    -parse-as-library \
    -target arm64-apple-macos13.0 \
    -O

if [ $? -ne 0 ]; then
    echo "❌ ARM64 build failed!"
    exit 1
fi

echo "  - Building for x86_64 (Intel)..."
swiftc Sources/BC64Keys/Localization.swift \
    Sources/BC64Keys/BC64KeysApp.swift \
    -o BC64Keys_x86_64 \
    -framework SwiftUI \
    -framework AppKit \
    -framework Carbon \
    -parse-as-library \
    -target x86_64-apple-macos13.0 \
    -O

if [ $? -ne 0 ]; then
    echo "❌ x86_64 build failed!"
    exit 1
fi

echo "  - Creating Universal Binary..."
lipo -create BC64Keys_arm64 BC64Keys_x86_64 -output BC64Keys_tmp
rm BC64Keys_arm64 BC64Keys_x86_64

if [ $? -ne 0 ]; then
    echo "❌ Universal binary creation failed!"
    exit 1
fi

echo "✅ Compilation successful!"

# Create app bundle structure
echo "📦 Creating app bundle..."
mkdir -p BC64Keys.app/Contents/MacOS
mkdir -p BC64Keys.app/Contents/Resources

# Move binary to app bundle
mv BC64Keys_tmp BC64Keys.app/Contents/MacOS/BC64Keys

# Copy app icon if available
if [ -f "AppIcon.icns" ]; then
    cp AppIcon.icns BC64Keys.app/Contents/Resources/
    echo "✅ App icon added"
fi

# Create Info.plist
cat > BC64Keys.app/Contents/Info.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>BC64Keys</string>
    <key>CFBundleIdentifier</key>
    <string>com.bc64.BC64Keys</string>
    <key>CFBundleName</key>
    <string>BC64Keys</string>
    <key>CFBundleDisplayName</key>
    <string>BC64Keys</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.7.0</string>
    <key>CFBundleVersion</key>
    <string>8</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

# Create PkgInfo
echo -n "APPL????" > BC64Keys.app/Contents/PkgInfo

echo "✅ App bundle created!"

# Code sign the app with a stable identifier
echo "🔏 Signing app..."
# Using a designated requirement to make the signature more stable
codesign --force --deep --sign - --identifier "com.bc64.BC64Keys" BC64Keys.app

if [ $? -eq 0 ]; then
    echo "✅ App signed successfully!"
    # Verify signature
    codesign -dv BC64Keys.app 2>&1 | grep -E "Identifier|Signature"
else
    echo "⚠️  Code signing failed (continuing anyway)"
fi

echo ""
echo "✅ BUILD COMPLETE!"
echo "📱 App location: BC64Keys.app"
echo "🚀 Run with: open BC64Keys.app"
echo ""
echo "⚠️  IMPORTANT: Grant Accessibility permissions!"
echo "   System Settings > Privacy & Security > Accessibility"
echo "   Add: BC64Keys (this app)"
