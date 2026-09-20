#!/bin/bash
set -e

echo "==> Building Ultra-Light Native macOS App for DarkTime v5.0..."

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build-mac"
APP_BUNDLE="$BUILD_DIR/DarkTime.app"
RELEASE_DIR="$ROOT_DIR/release"

rm -rf "$BUILD_DIR"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"
mkdir -p "$RELEASE_DIR"

# 1. Compile Native Binary (Apple Silicon arm64)
echo "--> Compiling native Swift binary..."
swiftc -O -target arm64-apple-macos11.0 "$ROOT_DIR/src-native-mac/main.swift" -o "$APP_BUNDLE/Contents/MacOS/DarkTime"
chmod +x "$APP_BUNDLE/Contents/MacOS/DarkTime"

# 2. Generate macOS .icns Icon
echo "--> Generating macOS ICNS icon..."
ICONSET_DIR="$BUILD_DIR/DarkTime.iconset"
mkdir -p "$ICONSET_DIR"
sips -z 16 16     "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_16x16.png" >/dev/null
sips -z 32 32     "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_16x16@2x.png" >/dev/null
sips -z 32 32     "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_32x32.png" >/dev/null
sips -z 64 64     "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_32x32@2x.png" >/dev/null
sips -z 128 128   "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_128x128.png" >/dev/null
sips -z 256 256   "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_128x128@2x.png" >/dev/null
sips -z 256 256   "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_256x256.png" >/dev/null
sips -z 512 512   "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_256x256@2x.png" >/dev/null
sips -z 512 512   "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_512x512.png" >/dev/null
sips -z 1024 1024 "$ROOT_DIR/img/clock.png" --out "$ICONSET_DIR/icon_512x512@2x.png" >/dev/null
iconutil -c icns "$ICONSET_DIR" -o "$APP_BUNDLE/Contents/Resources/DarkTime.icns"

# 3. Create Info.plist
echo "--> Creating Info.plist..."
cat << 'EOF' > "$APP_BUNDLE/Contents/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>DarkTime</string>
    <key>CFBundleIconFile</key>
    <string>DarkTime.icns</string>
    <key>CFBundleIdentifier</key>
    <string>com.darktime.app</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>DarkTime</string>
    <key>CFBundleDisplayName</key>
    <string>DarkTime</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>5.0.0</string>
    <key>CFBundleVersion</key>
    <string>5.0.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>11.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSHumanReadableCopyright</key>
    <string>Copyright © 2026 Md. Arman Hossen Ripon. All rights reserved.</string>
    <key>NSRequiresAquaSystemAppearance</key>
    <false/>
</dict>
</plist>
EOF

# 4. Copy Clean Web Assets into App Bundle
echo "--> Copying web assets to app bundle..."
mkdir -p "$APP_BUNDLE/Contents/Resources/www"
cp -R "$ROOT_DIR/www/"* "$APP_BUNDLE/Contents/Resources/www/"

# 5. Build Compressed DMG with Applications symlink
echo "--> Creating lightweight DMG installer..."
DMG_STAGING="$BUILD_DIR/dmg-staging"
mkdir -p "$DMG_STAGING"
cp -R "$APP_BUNDLE" "$DMG_STAGING/"
ln -s /Applications "$DMG_STAGING/Applications"

DMG_OUTPUT="$RELEASE_DIR/DarkTime-v5.0.dmg"
rm -f "$DMG_OUTPUT"
hdiutil create -volname "DarkTime" -srcfolder "$DMG_STAGING" -ov -format UDZO -imagekey zlib-level=9 "$DMG_OUTPUT"

echo "==> Build complete! Output DMG:"
ls -lh "$DMG_OUTPUT"
