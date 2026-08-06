# Drag & Drop AI Excel App

ドラッグ&ドロップしたデータを自動的にExcelでまとめるWindowsデスクトップアプリケーション

## 📋 概要

- **対応ファイル**: テキスト / CSV / 画像 / URL
- **機能**: データ自動整形 / 表形式統合 / グラフ作成（選択可能）
- **出力**: Excel（xlsx形式）
- **プラットフォーム**: Windows

## 🏗️ プロジェクト構成

```
drag-drop-AI-app/
├── frontend/                 # Electron + React
│   ├── src/
│   │   ├── main.js          # Electron メインプロセス
│   │   ├── preload.js       # セキュリティ層
│   │   ├── App.jsx          # React UI
│   │   ├── components/      # React コンポーネント
│   │   └── styles/          # CSS
│   ├── public/
│   └── package.json
├── backend/                  # Python
│   ├── app.py               # Flask サーバー
│   ├── processors/
│   │   ├── __init__.py
│   │   ├── text_processor.py
│   │   ├── csv_processor.py
│   │   ├── image_processor.py
│   │   └── url_processor.py
│   ├── excel_generator.py   # Excel生成エンジン
│   ├── config.py            # 設定ファイル
│   ├── requirements.txt
│   └── .env.example
├── .gitignore
└── README.md
```

## 🚀 環境構築

### 前提条件

- Node.js 16+
- Python 3.8+
- Windows 10/11

### インストール手順

#### 1. リポジトリをクローン

```bash
git clone https://github.com/masamasa0724/drag-drop-AI-app.git
cd drag-drop-AI-app
```

#### 2. フロントエンド（Electron + React）をセットアップ

```bash
cd frontend
npm install
```

#### 3. バックエンド（Python）をセットアップ

```bash
cd backend
python -m venv venv
venv\Scripts\activate  # Windows
pip install -r requirements.txt
```

## 🎯 機能

- ✅ **ドラッグ&ドロップ対応**: ファイルをウィンドウにドラッグして処理
- ✅ **複数ファイル形式対応**: テキスト、CSV、画像、URL
- ✅ **自動整形**: データを自動で表形式に変換
- ✅ **カスタマイズ可能**: 処理方法を選択できる
- ✅ **グラフ作成**: Excel内でグラフを自動生成
- ✅ **一括処理**: 複数ファイルを同時処理可能

## 📖 使い方

準備中...

## 📝 ライセンス

MIT License

## 👨‍💻 開発者

masamasa0724
