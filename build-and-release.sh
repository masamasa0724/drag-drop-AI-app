#!/bin/bash
# Build and Release Script for Drag & Drop AI Excel App

set -e  # Exit on error

echo "=========================================="
echo "Drag & Drop AI Excel App - Build & Release"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [ ! -f "frontend/package.json" ]; then
    echo "❌ Error: frontend/package.json not found"
    echo "Please run this script from the project root directory"
    exit 1
fi

echo -e "${BLUE}[1/5] Installing frontend dependencies...${NC}"
cd frontend
npm install

echo ""
echo -e "${BLUE}[2/5] Building React application...${NC}"
npm run build

echo ""
echo -e "${BLUE}[3/5] Building Windows executable...${NC}"
npm run electron-build-win

echo ""
echo -e "${BLUE}[4/5] Checking build output...${NC}"
if [ -d "dist" ]; then
    echo -e "${GREEN}✓ Build directory found${NC}"
    echo "Files generated:"
    ls -lh dist/ | grep -E '\.exe$' || echo "No EXE files found"
else
    echo -e "${YELLOW}⚠ dist directory not found${NC}"
fi

echo ""
echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}Build completed successfully!${NC}"
echo -e "${GREEN}==========================================${NC}"
echo ""
echo "📦 Output files location: frontend/dist/"
echo ""
echo "Next steps:"
echo "1. Upload files from frontend/dist/ to GitHub Releases"
echo "2. Share the download links with users"
echo ""
echo "To create a GitHub Release:"
echo "1. Go to: https://github.com/masamasa0724/drag-drop-AI-app/releases"
echo "2. Click 'Draft a new release'"
echo "3. Tag version: v0.1.0"
echo "4. Upload .exe files from frontend/dist/"
echo "5. Publish release"
echo ""
