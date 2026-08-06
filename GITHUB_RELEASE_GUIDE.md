# GitHub Releases Publication Guide

## 📋 前提条件

### 1. GitHub CLI (gh) をインストール

#### Windows
```bash
# Chocolatey を使用
choco install gh

# または Scoop を使用
scoop install gh

# または MSI をダウンロード
# https://github.com/cli/cli/releases
```

#### macOS
```bash
brew install gh
```

#### Linux
```bash
# Debian/Ubuntu
sudo apt install gh

# Fedora
sudo dnf install gh

# または
https://github.com/cli/cli/releases
```

### 2. GitHub で認証

```bash
gh auth login
```

対話型プロンプトに従って:
- ホスト: GitHub.com
- プロトコル: HTTPS
- 認証方法: Paste an authentication token
- トークン取得: https://github.com/settings/tokens

---

## 🚀 自動リリース作成（推奨）

### Windows

```bash
create-github-release.bat
```

### Linux/macOS

```bash
chmod +x create-github-release.sh
./create-github-release.sh
```

**自動実行内容:**
- ✅ バージョンを自動抽出
- ✅ リリースノートを自動生成
- ✅ EXE ファイルをアップロード
- ✅ GitHub Releases に公開

---

## 📝 手動リリース作成

### 方法 1: GitHub CLI (コマンドライン)

```bash
# 基本的なリリース作成
gh release create v0.1.0 frontend/dist/*.exe \
  --title "Drag & Drop AI Excel App v0.1.0" \
  --notes "Initial release"

# ファイル付きリリース作成（複数ファイル）
gh release create v0.1.0 \
  frontend/dist/Drag\ \&\ Drop\ AI\ Excel\ App-portable.exe \
  frontend/dist/Drag\ \&\ Drop\ AI\ Excel\ App\ Setup\ 0.1.0.exe \
  --title "Drag & Drop AI Excel App v0.1.0" \
  --notes-file RELEASE_NOTES.md
```

### 方法 2: GitHub Web UI

1. **GitHub を開く**
   - https://github.com/masamasa0724/drag-drop-AI-app

2. **Releases をクリック**
   - 右側の "Releases" セクション

3. **Draft a new release をクリック**

4. **リリース情報を入力**
   - Tag: `v0.1.0`
   - Release title: `Drag & Drop AI Excel App v0.1.0`
   - Description: 下記参照

5. **ファイルをアップロード**
   - `frontend/dist/` から EXE ファイルをドラッグ&ドロップ
   - または、ファイル選択ボタンをクリック

6. **Publish release をクリック**

---

## 📝 リリースノートテンプレート

```markdown
# Drag & Drop AI Excel App v0.1.0

## ✨ Features
- 🎯 Drag & drop file processing
- 📁 Support for Text, CSV, Image, and URL
- 📊 Automatic data formatting
- 📈 Excel file generation with charts
- 🔗 Multiple file merging
- 💻 Windows 10/11 native UI

## 📥 Download

### Portable Version (Recommended)
- **File**: `Drag & Drop AI Excel App-portable.exe`
- **Size**: ~300-400MB
- **No installation required**
- Simply download and run

### Installer Version
- **File**: `Drag & Drop AI Excel App Setup 0.1.0.exe`
- **Size**: ~350-450MB
- Installs to Program Files
- Creates shortcuts automatically

## 🚀 Getting Started

1. Download one of the .exe files above
2. Run by double-clicking
3. Drag files into the app
4. Click "Process" and "Export to Excel"

## 📋 System Requirements

- Windows 10 or later
- 4GB RAM (8GB recommended)
- 500MB disk space
- .NET Framework (included in Windows)

## 📖 Documentation

- [Setup Guide](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/SETUP.md)
- [User Manual (Japanese)](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/frontend/README_JP.md)
- [Build Guide](https://github.com/masamasa0724/drag-drop-AI-app/blob/main/WINDOWS_BUILD.md)

## 🐛 Known Issues

- Image OCR requires Tesseract for full functionality
- Large files (>50MB) process slower
- Charts limited to bar charts

## 🤝 Support

- Report bugs: [Issues](https://github.com/masamasa0724/drag-drop-AI-app/issues)
- Feature requests: [Discussions](https://github.com/masamasa0724/drag-drop-AI-app/discussions)

## 📄 License

MIT License

---

**Built with**: Electron • React • Flask • openpyxl
```

---

## ✅ リリース後の確認

### 1. リリースページを確認
```bash
gh release view v0.1.0
```

### 2. ダウンロードリンクをテスト
- https://github.com/masamasa0724/drag-drop-AI-app/releases/tag/v0.1.0

### 3. EXE ファイルをダウンロード・テスト
- ポータブル版を実行
- インストーラー版を実行
- 主要機能をテスト

---

## 🔒 GitHub Releases のセキュリティ

### チェックサムの確認

```bash
# SHA256 チェックサムを計算（Windows PowerShell）
Get-FileHash "Drag & Drop AI Excel App-portable.exe" -Algorithm SHA256

# Linux/macOS
sha256sum Drag\ \&\ Drop\ AI\ Excel\ App-portable.exe
```

### リリースに署名（オプション）

```bash
# GPG キーで署名
gh release create v0.1.0 frontend/dist/*.exe --sign
```

---

## 📊 リリース統計

```bash
# リリース一覧表示
gh release list

# 特定のリリース情報表示
gh release view v0.1.0

# ダウンロード数確認（GitHub web）
# https://github.com/masamasa0724/drag-drop-AI-app/releases
```

---

## 🔄 アップデート（次のバージョン）

### v0.2.0 をリリース

```bash
# 新しいタグでリリース
gh release create v0.2.0 frontend/dist/*.exe \
  --title "Drag & Drop AI Excel App v0.2.0" \
  --notes "New features and bug fixes"
```

---

## 💡 ベストプラクティス

✅ **推奨:**
- セマンティック バージョニングを使用 (v0.1.0, v0.2.0)
- すべてのコミットがタグに含まれる
- リリースノートは詳細に
- チェックサムを公開
- 複数の配布形式を提供

❌ **避けるべき:**
- タグなしでリリース
- リリースノートが不明瞭
- ビルド成果物のない場合
- 古いバージョンの削除

---

## 🆘 トラブルシューティング

### 「gh: command not found」
```bash
# GitHub CLI をインストール
choco install gh  # Windows
brew install gh   # macOS
```

### 「not authenticated」
```bash
gh auth login
```

### 「release already exists」
```bash
# 既存のリリースを削除
gh release delete v0.1.0 --yes

# 再作成
gh release create v0.1.0 frontend/dist/*.exe
```

### ファイルアップロード失敗
```bash
# ファイルサイズを確認
ls -lh frontend/dist/*.exe

# 個別にアップロード
gh release upload v0.1.0 "frontend/dist/Drag & Drop AI Excel App-portable.exe"
```

---

## 📞 サポート

問題が発生した場合:

1. **GitHub CLI ヘルプ**
   ```bash
   gh release --help
   ```

2. **ドキュメント**
   - https://cli.github.com/manual/gh_release

3. **Issues**
   - https://github.com/masamasa0724/drag-drop-AI-app/issues

---

**Happy Releasing! 🚀**
