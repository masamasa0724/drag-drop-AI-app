# セットアップガイド

## 前提条件

- **Node.js 16+** - [ダウンロード](https://nodejs.org/)
- **Python 3.8+** - [ダウンロード](https://www.python.org/)
- **Git** - [ダウンロード](https://git-scm.com/)

---

## インストール手順

### 1️⃣ リポジトリをクローン

```bash
git clone https://github.com/masamasa0724/drag-drop-AI-app.git
cd drag-drop-AI-app
```

### 2️⃣ バックエンド（Python）をセットアップ

```bash
cd backend

# 仮想環境を作成
python -m venv venv

# 仮想環境を有効化（Windows）
venv\Scripts\activate

# macOS/Linux の場合
source venv/bin/activate

# 依存パッケージをインストール
pip install -r requirements.txt
```

### 3️⃣ フロントエンド（Electron + React）をセットアップ

別のターミナルで：

```bash
cd frontend
npm install
```

---

## アプリの起動

### ターミナル1: バックエンドサーバーを起動

```bash
cd backend
python app.py
```

✅ 出力例：
```
 * Running on http://localhost:5000
 * Press CTRL+C to quit
```

### ターミナル2: Electronアプリを起動

```bash
cd frontend
npm run electron-dev
```

✅ Electronウィンドウが起動します

---

## 使い方

1. **ファイルをドラッグ&ドロップ**
   - テキスト、CSV、画像、URLに対応

2. **処理オプションを選択**
   - 📊 自動整形
   - 📈 グラフ作成
   - 🔗 複数ファイル統合

3. **処理開始**
   - 「処理開始」ボタンをクリック

4. **Excelでエクスポート**
   - 「Excelでエクスポート」ボタンをクリック
   - 保存先を選択

---

## トラブルシューティング

| エラー | 対処法 |
|--------|--------|
| `ModuleNotFoundError` | `pip install -r requirements.txt` を再実行 |
| `Port 5000 already in use` | `backend/.env` で `PORT=5001` に変更 |
| `npm: command not found` | Node.js を再インストール |
| `electron: command not found` | `npm install` を再実行 |

---

## 環境変数の設定（オプション）

`backend/.env` ファイルを作成：

```env
FLASK_ENV=development
FLASK_DEBUG=True
PORT=5000
HOST=localhost
```

---

## 開発用コマンド

### フロントエンド

```bash
npm start          # React開発サーバーのみ
npm run electron   # Electronアプリのみ
npm run build      # 本番ビルド
npm test           # テスト実行
```

### バックエンド

```bash
python app.py      # サーバー起動
python -m pytest   # テスト実行（テストファイル追加時）
```

---

## ビルド（exe化）

```bash
cd frontend
npm run electron-build
```

→ `out/` フォルダに Windows インストーラが生成されます

---

## サポート

問題が発生した場合は、[Issues](https://github.com/masamasa0724/drag-drop-AI-app/issues) を作成してください。

