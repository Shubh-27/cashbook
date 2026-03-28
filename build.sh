#!/bin/bash

# ============================================================
#  build.sh - Production Build Script for CashBook (Unified)
#  Produces both macOS DMG and Windows EXE at electron/dist/
# ============================================================

set -e # Exit on error

ROOT=$(pwd)
API_OUTPUT="$ROOT/electron/resources/api"

echo ""
echo "=================================================="
echo "  CashBook - Unified Production Build"
echo "=================================================="
echo ""

# ----------------------------------------------------------
# Step 1: Build React Frontend
# ----------------------------------------------------------
echo "[Step 1/3] Building React frontend..."
cd "$ROOT/frontend"
npm run build
echo "[Step 1/3] Frontend built -> electron/ui/"
echo ""


# ----------------------------------------------------------
# Step 2: Build for macOS
# ----------------------------------------------------------
echo "[Step 2/3] Building for macOS..."

# Determine architecture
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    RUNTIME="osx-arm64"
else
    RUNTIME="osx-x64"
fi

echo "  Publishing .NET backend ($RUNTIME)..."
# Clear previous api artifacts
rm -rf "$API_OUTPUT"
mkdir -p "$API_OUTPUT"

cd "$ROOT/backend"
dotnet publish backend/backend.csproj \
  --configuration Release \
  --runtime $RUNTIME \
  --self-contained true \
  -p:PublishSingleFile=true \
  -p:PublishTrimmed=false \
  -p:DebugType=none \
  -p:DebugSymbols=false \
  -p:IncludeNativeLibrariesForSelfExtract=true \
  --output "$API_OUTPUT"

echo "  Packaging macOS application..."
cd "$ROOT/electron"
# Ensure electron dependencies are installed
if [ ! -d "node_modules" ]; then
    npm install
fi
npx electron-builder --mac
echo ""


# ----------------------------------------------------------
# Step 3: Build for Windows
# ----------------------------------------------------------
echo "[Step 3/3] Building for Windows..."

RUNTIME="win-x64"
echo "  Publishing .NET backend ($RUNTIME)..."
# Clear macOS api artifacts
rm -rf "$API_OUTPUT"
mkdir -p "$API_OUTPUT"

cd "$ROOT/backend"
dotnet publish backend/backend.csproj \
  --configuration Release \
  --runtime $RUNTIME \
  --self-contained true \
  -p:PublishSingleFile=true \
  -p:PublishTrimmed=false \
  -p:DebugType=none \
  -p:DebugSymbols=false \
  -p:IncludeNativeLibrariesForSelfExtract=true \
  --output "$API_OUTPUT"

echo "  Packaging Windows application..."
cd "$ROOT/electron"
npx electron-builder --win
echo ""


echo "=================================================="
echo "  BUILD COMPLETE!"
echo "  Artifacts in electron/dist/:"
echo "    - macOS: *.dmg"
echo "    - Windows: *.exe"
echo "=================================================="
echo ""

cd "$ROOT"

