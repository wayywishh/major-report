#!/bin/bash

# === CONFIGURATION ===
MAIN_TEX="main.tex"
OUTPUT_DIR="outputs"
VERSION_FILE="version.txt"
DATE=$(date +%Y-%m-%d)

# === READ & INCREMENT VERSION ===
if [ ! -f "$VERSION_FILE" ]; then
    echo "v1" > "$VERSION_FILE"
fi

CURRENT_VERSION=$(cat "$VERSION_FILE")
VERSION_NUM=$(echo "$CURRENT_VERSION" | grep -o '[0-9]*')
NEW_VERSION_NUM=$((VERSION_NUM + 1))
NEW_VERSION="v$NEW_VERSION_NUM"
echo "$NEW_VERSION" > "$VERSION_FILE"

# === OUTPUT FOLDER ===
BUILD_DIR="${OUTPUT_DIR}/report_${CURRENT_VERSION}_${DATE}"
mkdir -p "$BUILD_DIR"

# === COMPILE ===
pdflatex -output-directory="$BUILD_DIR" "$MAIN_TEX"
pdflatex -output-directory="$BUILD_DIR" "$MAIN_TEX"

# === OUTPUT ===
if [ -f "$BUILD_DIR/main.pdf" ]; then
    echo "✅ Build complete: $BUILD_DIR/main.pdf"
    echo "Next version will be: $NEW_VERSION"
else
    echo "❌ Build failed."
fi
