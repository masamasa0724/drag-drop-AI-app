#!/bin/bash
# GitHub Release Creation Script
# Requirements: GitHub CLI (gh) must be installed and authenticated
# Installation: https://cli.github.com/

set -e

echo "=========================================="
echo "GitHub Release Creator"
echo "=========================================="
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ Error: GitHub CLI (gh) is not installed"
    echo ""
    echo "Install GitHub CLI:"
    echo "  Windows (Chocolatey): choco install gh"
    echo "  Windows (Scoop): scoop install gh"
    echo "  macOS (Homebrew): brew install gh"
    echo "  Linux: https://github.com/cli/cli/releases"
    echo ""
    echo "After installation, run: gh auth login"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Error: Not authenticated with GitHub CLI"
    echo ""
    echo "Run: gh auth login"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "frontend/package.json" ]; then
    echo "❌ Error: frontend/package.json not found"
    echo "Please run this script from the project root directory"
    exit 1
fi

# Check if dist directory exists
if [ ! -d "frontend/dist" ]; then
    echo "❌ Error: frontend/dist directory not found"
    echo "Please build the application first using: build-and-release.sh"
    exit 1
fi

# Get version from package.json
VERSION=$(grep '"version"' frontend/package.json | head -1 | awk -F'"' '{print $4}')
TAG="v${VERSION}"

echo "📦 Release Information:"
echo "  Version: ${VERSION}"
echo "  Tag: ${TAG}"
echo ""

# Check if tag already exists
if gh release view "${TAG}" &> /dev/null; then
    echo "⚠️  Warning: Release ${TAG} already exists"
    read -p "Do you want to delete and recreate it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🗑️  Deleting existing release..."
        gh release delete "${TAG}" --yes
    else
        echo "Cancelled."
        exit 0
    fi
fi

echo "📝 Creating GitHub Release..."
echo ""

# Create release notes
RELEASE_NOTES="# Drag & Drop AI Excel App v${VERSION}

## ✨ Features
- 🎯 Intuitive drag & drop interface
- 📁 Support for multiple file formats (Text, CSV, Image, URL)
- 📊 Automatic data formatting and Excel generation
- 📈 Optional chart creation
- 🔗 Multiple file merging capability
- 💻 Windows 10/11 native integration

## 📋 System Requirements
- **OS**: Windows 10 or later
- **RAM**: 4GB minimum (8GB recommended)
- **Disk Space**: 500MB for installation
- **Python**: 3.8+ (for backend server)

## 📥 Installation Options

### Option 1: Portable Version (Recommended)
- File: \`Drag & Drop AI Excel App-portable.exe\`
- Size: ~300-400MB
- **No installation required**
- Just download and run

### Option 2: Installer Version
- File: \`Drag & Drop AI Excel App Setup 0.1.0.exe\`
- Size: ~350-450MB
- Installs to Program Files
- Creates Start Menu shortcuts
- Creates Desktop shortcut

## 🚀 Quick Start

1. **Download** one of the .exe files above
2. **Run** by double-clicking
3. **Drag & Drop** files into the application
4. **Process** and **Export to Excel**

## 📖 Documentation

- [Setup Guide](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/SETUP.md)
- [Windows Build Guide](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/WINDOWS_BUILD.md)
- [Changelog](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/CHANGELOG.md)

## 🐛 Known Issues

- Image OCR requires Tesseract installation for full functionality
- Large files (>50MB) may take longer to process
- Chart generation currently supports bar charts only

## 💡 Tips

- **Text Files**: Supports CSV-like formats and line-separated data
- **Images**: Automatically extracts text using OCR
- **URLs**: Automatically scrapes tables and text content
- **Multiple Files**: Use the merge option to combine data from multiple files

## 🔒 Security Notes

- This application processes files locally
- No data is sent to external servers
- All files remain on your computer
- Backend runs locally on your machine

## 🤝 Support

- 🐛 [Report Issues](https://github.com/masamasa0724/drag-drop-AI-app/issues)
- 💡 [Feature Requests](https://github.com/masamasa0724/drag-drop-AI-app/discussions)
- 📧 Contact: masamasa0724@example.com

## 📄 License

MIT License - See LICENSE file for details

---

**Built with**: Electron • React • Flask • openpyxl

**Last Updated**: $(date +%Y-%m-%d)
"

# Upload the release
echo "📤 Uploading files..."

# Create release with notes
gh release create "${TAG}" \
    --title "Drag & Drop AI Excel App v${VERSION}" \
    --notes "${RELEASE_NOTES}" \
    frontend/dist/*.exe 2>/dev/null || true

echo ""
echo "✅ Release created successfully!"
echo ""
echo "🔗 Release URL: https://github.com/masamasa0724/drag-drop-AI-app/releases/tag/${TAG}"
echo ""
echo "📊 Release includes:"
ls -lh frontend/dist/*.exe | awk '{print "  ✓ " $9 " (" $5 ")"}'
echo ""
echo "🎉 Your application is now available for download!"
echo ""
