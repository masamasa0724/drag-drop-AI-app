# Windows アプリケーションビルドガイド

## 🎯 概要

このガイドでは、Drag & Drop AI Excel App を Windows スタンドアロンアプリケーション（EXE/MSI）としてビルド・配布する手順を説明します。

---

## 📋 前提条件

- **Node.js 16+** - [ダウンロード](https://nodejs.org/)
- **Python 3.8+** - バックエンド用
- **Visual Studio Build Tools** または **Visual Studio Community**（オプション）
- Windows 10 以上

---

## 🚀 ビルド手順

### ステップ1: 依存パッケージをインストール

```bash
cd frontend
npm install

cd ../backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

### ステップ2: Windows アプリケーションをビルド

#### オプション A: ポータブル EXE（推奨）
```bash
cd frontend
npm run electron-build-win
```

#### オプション B: NSIS インストーラー（MSI）
```bash
cd frontend
npm run electron-build-win-nsis
```

出力ファイル：
- `dist/Drag & Drop AI Excel App-portable.exe` - ポータブル版
- `dist/Drag & Drop AI Excel App Setup 0.1.0.exe` - インストーラー版

### ステップ3: ビルド成功確認

```bash
ls dist/  # Windows では Explorer で確認
```

---

## 📦 配布方法

### A. ポータブル版の配布

1. `dist/Drag & Drop AI Excel App-portable.exe` をユーザーに配布
2. ユーザーがダブルクリックで実行
3. インストール不要

### B. インストーラー版の配布

1. `dist/Drag & Drop AI Excel App Setup 0.1.0.exe` をユーザーに配布
2. ユーザーがインストーラーを実行
3. スタート メニュー、デスクトップショートカット自動作成

---

## 🔧 トラブルシューティング

### エラー: "Cannot find module 'electron'"
```bash
cd frontend
rm -r node_modules
npm install
```

### エラー: "Port 3000 already in use"
```bash
# 別のポートを使用
set PORT=3001
npm start
```

### エラー: "Build failed"
```bash
# キャッシュをクリア
rm -r dist build
npm run electron-build-win
```

---

## 📝 カスタマイズ

### アプリケーションアイコンの変更

1. `frontend/public/icon.ico` を置き換え（256x256 以上推奨）
2. 再ビルド

```bash
npm run electron-build-win
```

### アプリケーション情報の編集

`frontend/package.json` の `build` セクションを編集：

```json
"build": {
  "appId": "com.dragdrop.app",
  "productName": "あなたのアプリ名"
}
```

---

## ✅ テスト方法

### 1. 開発環境で動作確認

```bash
# ターミナル1: バックエンド
cd backend
python app.py

# ターミナル2: フロントエンド
cd frontend
npm run electron-dev
```

### 2. ビルド版で動作確認

```bash
cd frontend
cd dist
# ポータブル版を実行
.\Drag & Drop AI Excel App-portable.exe
```

---

## 📊 ビルドファイル構成

```
frontend/
├── dist/
│   ├── Drag & Drop AI Excel App-portable.exe      # ポータブル版
│   └── Drag & Drop AI Excel App Setup 0.1.0.exe   # インストーラー版
├── build/                                          # React ビルド出力
├── public/
│   ├── electron.js
│   ├── preload.js
│   ├── icon.ico                                    # アプリアイコン
│   └── index.html
└── src/
```

---

## 🔒 署名（オプション）

コード署名を追加する場合：

```json
"win": {
  "certificateFile": "path/to/certificate.pfx",
  "certificatePassword": "your-password",
  "signingHashAlgorithms": ["sha256"]
}
```

---

## 📲 インストーラーのカスタマイズ

`frontend/package.json` の `nsis` セクション：

```json
"nsis": {
  "oneClick": false,                    # インストール方法を選択可能
  "allowToChangeInstallationDirectory": true,  # インストール先指定可能
  "createDesktopShortcut": true,        # デスクトップショートカット作成
  "createStartMenuShortcut": true,      # スタートメニューショートカット作成
  "shortcutName": "Drag & Drop AI Excel App"
}
```

---

## 🚢 リリース

### GitHub Releases への登録

1. GitHub リポジトリを開く
2. **Releases** → **Draft a new release**
3. タグ: `v0.1.0`
4. タイトル: `Drag & Drop AI Excel App v0.1.0`
5. EXE ファイルをアップロード
6. **Publish release**

---

## 💡 チェックリスト

- [ ] 依存パッケージインストール完了
- [ ] バックエンド動作確認（`python app.py`）
- [ ] 開発版動作確認（`npm run electron-dev`）
- [ ] ビルド成功（`npm run electron-build-win`）
- [ ] ポータブル版テスト実行
- [ ] インストーラー版テスト実行
- [ ] アイコン確認
- [ ] メニュー動作確認

---

## 📞 サポート

問題が発生した場合：

1. [Issues](https://github.com/masamasa0724/drag-drop-AI-app/issues) で報告
2. ログを確認: `%APPDATA%/Drag & Drop AI Excel App`

