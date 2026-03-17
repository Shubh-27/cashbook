#!/bin/bash

# ============================================================
#  build.sh - Production Build Script for CashBook (Mac)
#  Produces a macOS DMG/Zip at electron/dist/
#  How to use on Mac
#  1. Open your terminal on Mac.
#  2. Navigate to the project root directory.
#  3. Make the script executable: chmod +x build.sh
#  4. Run the build script: ./build.sh
# ============================================================

set -e # Exit on error

ROOT=$(pwd)

echo ""
echo "=================================================="
echo "  CashBook - Production Build (macOS)"
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
# Step 2: Publish ASP.NET Backend
# ----------------------------------------------------------
echo "[Step 2/3] Publishing ASP.NET backend..."

API_OUTPUT="$ROOT/electron/resources/api"

# Determine architecture
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    RUNTIME="osx-arm64"
else
    RUNTIME="osx-x64"
fi

echo "  Targeting runtime: $RUNTIME"

cd "$ROOT/backend"
# Note: We assume the csproj is at backend/backend.csproj relative to the backend folder
# or just backend.csproj if the user is already in the backend folder.
# Based on build.ps1, it was: dotnet publish backend\backend.csproj ...
# Since we are already in $ROOT/backend, it should be:
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

echo "[Step 2/3] Backend published -> electron/resources/api/"
echo ""

# ----------------------------------------------------------
# Step 3: Package with electron-builder
# ----------------------------------------------------------
echo "[Step 3/3] Packaging with electron-builder..."

cd "$ROOT/electron"

# Ensure electron dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "  Installing electron dependencies..."
    npm install
fi

npm run dist
echo ""

echo "=================================================="
echo "  BUILD COMPLETE!"
echo "  Artifacts: electron/dist/*.dmg"
echo "=================================================="
echo ""

cd "$ROOT"
