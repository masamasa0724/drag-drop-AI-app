import React, { useState } from 'react';
import './App.css';
import DropZone from './components/DropZone';
import OptionPanel from './components/OptionPanel';
import PreviewTable from './components/PreviewTable';

function App() {
  const [files, setFiles] = useState([]);
  const [processedData, setProcessedData] = useState(null);
  const [options, setOptions] = useState({
    autoFormat: true,
    createChart: false,
    mergeData: false,
  });
  const [isProcessing, setIsProcessing] = useState(false);
  const [error, setError] = useState(null);

  const handleDropFiles = (droppedFiles) => {
    setFiles(droppedFiles);
    setError(null);
  };

  const handleProcess = async () => {
    if (files.length === 0) {
      setError('ファイルを選択してください');
      return;
    }

    setIsProcessing(true);
    setError(null);

    try {
      const fileData = await Promise.all(
        files.map(async (file) => ({
          name: file.name,
          type: file.type,
          content: await file.text(),
        }))
      );

      const response = await window.api.processFiles(fileData, options);
      setProcessedData(response);
    } catch (err) {
      setError(`エラー: ${err.message}`);
      console.error(err);
    } finally {
      setIsProcessing(false);
    }
  };

  const handleExport = async () => {
    if (!processedData) {
      setError('処理済みデータがありません');
      return;
    }

    try {
      const savePath = await window.api.selectSavePath();
      if (!savePath) return;

      // Send export request to backend
      const response = await fetch('http://localhost:5000/api/export', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          data: processedData,
          savePath,
        }),
      });

      if (response.ok) {
        alert('Excelファイルが正常に作成されました！');
        setFiles([]);
        setProcessedData(null);
      } else {
        setError('エクスポートに失敗しました');
      }
    } catch (err) {
      setError(`エクスポートエラー: ${err.message}`);
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>🎯 Drag & Drop AI Excel App</h1>
        <p>データをドラッグして、自動でExcelにまとめます</p>
      </header>

      <main className="App-main">
        <div className="container">
          <div className="left-panel">
            <DropZone onDrop={handleDropFiles} files={files} />
            <OptionPanel options={options} setOptions={setOptions} />
            <div className="button-group">
              <button
                className="btn btn-primary"
                onClick={handleProcess}
                disabled={isProcessing || files.length === 0}
              >
                {isProcessing ? '処理中...' : '処理開始'}
              </button>
              <button
                className="btn btn-success"
                onClick={handleExport}
                disabled={!processedData}
              >
                📥 Excelでエクスポート
              </button>
            </div>
          </div>

          <div className="right-panel">
            {error && <div className="error-message">⚠️ {error}</div>}
            {processedData && <PreviewTable data={processedData} />}
          </div>
        </div>
      </main>
    </div>
  );
}

export default App;
