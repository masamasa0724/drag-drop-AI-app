# Release Checklist

## Pre-Release Checklist ✓

- [ ] All code committed to main branch
- [ ] CHANGELOG.md updated
- [ ] Version number updated in package.json (v0.1.0)
- [ ] README.md reviewed
- [ ] Documentation complete
- [ ] Tests passing (if applicable)

## Build Checklist ✓

- [ ] Run `npm install` in frontend directory
- [ ] Run `npm run electron-build-win`
- [ ] Verify dist/ directory contains .exe files
- [ ] Test portable version (Drag & Drop AI Excel App-portable.exe)
- [ ] Test installer version (Setup .exe)
- [ ] Check file sizes are reasonable (< 500MB)

## Portable Version Test ✓

- [ ] Download portable .exe
- [ ] Execute without installation
- [ ] Verify all features work:
  - [ ] Drag and drop files
  - [ ] Process text files
  - [ ] Process CSV files
  - [ ] Process images (if Tesseract installed)
  - [ ] Export to Excel
  - [ ] Open exported Excel file
- [ ] Test error handling
- [ ] Verify UI rendering
- [ ] Check backend server connection

## Installer Version Test ✓

- [ ] Download Setup .exe
- [ ] Run installer wizard
- [ ] Verify installation directory
- [ ] Check desktop shortcut created
- [ ] Check Start Menu entry created
- [ ] Launch from Start Menu
- [ ] Uninstall and verify cleanup

## GitHub Release Preparation ✓

- [ ] Create release tag (v0.1.0)
- [ ] Write release notes:
  - [ ] Features
  - [ ] Bug fixes
  - [ ] Known issues
  - [ ] System requirements
- [ ] Upload portable .exe
- [ ] Upload installer .exe
- [ ] Add checksums (SHA256)
- [ ] Set as Latest Release

## Post-Release ✓

- [ ] Publish GitHub Release
- [ ] Create release announcement
- [ ] Test download links
- [ ] Monitor for issues
- [ ] Plan next version

## Distribution Channels

### GitHub Releases (Recommended)
- URL: https://github.com/masamasa0724/drag-drop-AI-app/releases
- Format: Direct download
- Update: Manual

### Optional: Windows Store
- Requires: Microsoft Developer Account
- Process: MSIX packaging
- Benefits: Automatic updates

### Optional: Installer Hosting
- Host: Your website/server
- Format: Direct download
- Update: Manual

## Release Notes Template

```markdown
# Release v0.1.0 - Drag & Drop AI Excel App

## 🎉 Features
- ✅ Drag and drop file support
- ✅ Text, CSV, Image, URL processing
- ✅ Automatic Excel file generation
- ✅ Graph creation option
- ✅ Data merging capability

## 🐛 Bug Fixes
- Fixed file encoding issues
- Improved error handling

## 📋 System Requirements
- Windows 10 or later
- 4GB RAM (8GB recommended)
- 500MB disk space
- Python 3.8+ (for backend)
- Node.js 16+ (for development)

## 📥 Installation

### Option A: Portable Version (Recommended)
1. Download: Drag & Drop AI Excel App-portable.exe
2. Double-click to run
3. No installation needed

### Option B: Installer
1. Download: Drag & Drop AI Excel App Setup 0.1.0.exe
2. Follow the installer wizard
3. Launch from Start Menu

## 🔒 Security & Checksums

**SHA256 Checksums:**
```
portable.exe: [SHA256]
setup.exe: [SHA256]
```

## 📖 Documentation
- Setup Guide: [SETUP.md](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/SETUP.md)
- Windows Build Guide: [WINDOWS_BUILD.md](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/WINDOWS_BUILD.md)
- User Manual: [README_JP.md](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/frontend/README_JP.md)

## 🆘 Support
- Issues: https://github.com/masamasa0724/drag-drop-AI-app/issues
- Discussions: https://github.com/masamasa0724/drag-drop-AI-app/discussions
```

## Version History

- **v0.1.0** (Current) - Initial release
  - Windows 10/11 support
  - Text, CSV, Image, URL processing
  - Excel generation with formatting
  - Graph creation

## Next Release Planning

- **v0.2.0** (Planned)
  - [ ] PDF support
  - [ ] Advanced formatting options
  - [ ] Data validation
  - [ ] Template support

- **v0.3.0** (Planned)
  - [ ] Cloud storage integration
  - [ ] Batch processing
  - [ ] Plugin system
  - [ ] Auto-update feature
