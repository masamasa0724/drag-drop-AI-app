import React, { useState } from 'react';
import './DropZone.css';

function DropZone({ onDrop, files }) {
  const [isDragging, setIsDragging] = useState(false);

  const handleDragOver = (e) => {
    e.preventDefault();
    setIsDragging(true);
  };

  const handleDragLeave = () => {
    setIsDragging(false);
  };

  const handleDrop = (e) => {
    e.preventDefault();
    setIsDragging(false);

    const droppedFiles = Array.from(e.dataTransfer.files);
    onDrop(droppedFiles);
  };

  return (
    <div
      className={`drop-zone ${isDragging ? 'dragging' : ''}`}
      onDragOver={handleDragOver}
      onDragLeave={handleDragLeave}
      onDrop={handleDrop}
    >
      <div className="drop-content">
        <p className="drop-icon">📁</p>
        <p className="drop-text">ファイルをここにドラッグして下さい</p>
        <p className="drop-hint">テキスト, CSV, 画像, URL に対応</p>
      </div>

      {files.length > 0 && (
        <div className="file-list">
          <h3>選択ファイル ({files.length})</h3>
          <ul>
            {files.map((file, idx) => (
              <li key={idx}>
                <span className="file-icon">📄</span>
                <span>{file.name}</span>
                <span className="file-size">({(file.size / 1024).toFixed(2)} KB)</span>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

export default DropZone;
