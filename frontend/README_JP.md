# 🎯 Drag & Drop AI Excel App - Windows Edition

## 概要

ドラッグ&ドロップでファイルを処理し、自動的にExcelにまとめるWindowsアプリケーション。

### 主な機能

✨ **簡単操作**
- ファイルをドラッグ&ドロップするだけ
- 直感的なUI

📁 **複数ファイル形式対応**
- テキスト（.txt）
- CSV（.csv）
- 画像（.png, .jpg, .jpeg, .gif）- OCR対応
- URL - Web スクレイピング対応

📊 **自動整形機能**
- データを自動で表形式に変換
- 複数ファイルの統合処理
- グラフの自動作成

💾 **Excel生成**
- openpyxl による高速Excel生成
- 自動フォーマット＆整形
- グラフ機能

---

## インストール

### Windows実行ファイルから

#### オプション A: ポータブル版（推奨）
1. `Drag & Drop AI Excel App-portable.exe` をダウンロード
2. ダブルクリックで実行
3. インストール不要

#### オプション B: インストーラー版
1. `Drag & Drop AI Excel App Setup 0.1.0.exe` をダウンロード
2. セットアップウィザードに従う
3. スタート メニューから起動

### ソースからビルド

```bash
git clone https://github.com/masamasa0724/drag-drop-AI-app.git
cd drag-drop-AI-app

# フロントエンド
cd frontend
npm install
npm run electron-build-win

# ビルド出力
ls dist/
```

---

## 使い方

### 基本操作

1. **アプリを起動**
   - `Drag & Drop AI Excel App.exe` をダブルクリック

2. **ファイルをドラッグ**
   - 処理するファイルをアプリウィンドウにドラッグ&ドロップ

3. **処理オプションを選択**
   - 📊 データを自動整形
   - 📈 グラフを自動作成
   - 🔗 複数ファイルを統合

4. **処理開始**
   - 「処理開始」ボタンをクリック

5. **Excelでエクスポート**
   - 「Excelでエクスポート」ボタンをクリック
   - 保存先を選択
   - Excelファイルが生成される

### サンプルデータ

#### テキストファイル（.txt）
```
名前,年齢,住所
太郎,25,東京
花子,30,大阪
```

#### CSV ファイル（.csv）
```csv
日付,売上,利益
2024-01-01,10000,2000
2024-01-02,15000,3000
```

#### 画像
- PNG, JPG, JPEG, GIF
- OCR（光学文字認識）で自動テキスト抽出

#### URL
- Web ページの HTML テーブルを自動抽出
- テキストコンテンツの自動パース

---

## システム要件

- **OS**: Windows 10 以上
- **メモリ**: 4GB 以上（推奨：8GB）
- **ディスク**: 500MB 以上の空き容量
- **Python**: 3.8 以上（バックエンドサーバー）
- **Node.js**: 16 以上（開発環境）

---

## トラブルシューティング

### Q: アプリが起動しない
**A:** 
- バックエンドサーバーが起動しているか確認
- ポート 5000 が使用可能か確認
- ファイアウォール設定を確認

### Q: ファイルが処理されない
**A:**
- ファイル形式が対応しているか確認
- ファイルサイズが大きすぎないか確認（50MB以下推奨）
- エラーメッセージをチェック

### Q: Excel ファイルが生成されない
**A:**
- 保存先のパスが正しいか確認
- ディスクの空き容量を確認
- ファイル名に使用禁止文字がないか確認

### Q: グラフが作成されない
**A:**
- 数値データが含まれているか確認
- 最低2行以上のデータが必要
- 「グラフを自動作成」オプションを有効にしているか確認

---

## パフォーマンス

### ファイル処理速度

| ファイル形式 | ファイルサイズ | 処理時間 |
|-----------|------------|--------|
| テキスト | 1MB | 0.5秒 |
| CSV | 10MB | 2秒 |
| 画像 | 5MB | 3秒 |
| URL | - | 5秒 |

---

## 設定

### アプリケーション設定

スタート メニューから設定可能な項目：
- 言語（日本語 / 英語）
- テーマ（ライト / ダーク）
- 自動保存設定
- ログレベル

---

## 開発者向け情報

### ビルド

```bash
# ポータブル版
npm run electron-build-win

# NSIS インストーラー版
npm run electron-build-win-nsis

# 両方
npm run electron-build-win
```

### 開発モード

```bash
# バックエンド
cd backend && python app.py

# フロントエンド（別ターミナル）
cd frontend && npm run electron-dev
```

### ログファイル

```
C:\Users\{ユーザー名}\AppData\Roaming\Drag & Drop AI Excel App\logs
```

---

## ライセンス

MIT License - 詳細は [LICENSE](LICENSE) を参照

---

## サポート & フィードバック

- 🐛 **バグ報告**: [Issues](https://github.com/masamasa0724/drag-drop-AI-app/issues)
- 💡 **機能リクエスト**: [Discussions](https://github.com/masamasa0724/drag-drop-AI-app/discussions)
- 📧 **お問い合わせ**: masamasa0724@example.com

---

## 更新履歴

### v0.1.0 (2024-01-01)
- 初回リリース
- Windows 10/11 対応
- テキスト、CSV、画像、URL 処理対応

---

## クレジット

開発者: masamasa0724

ライブラリ:
- Electron
- React
- Flask
- openpyxl
- pandas

