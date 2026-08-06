import React from 'react';
import './OptionPanel.css';

function OptionPanel({ options, setOptions }) {
  const handleChange = (key) => {
    setOptions((prev) => ({
      ...prev,
      [key]: !prev[key],
    }));
  };

  return (
    <div className="option-panel">
      <h2>⚙️ 処理オプション</h2>

      <div className="option-item">
        <label className="checkbox">
          <input
            type="checkbox"
            checked={options.autoFormat}
            onChange={() => handleChange('autoFormat')}
          />
          <span className="checkmark"></span>
          <span>データを自動整形</span>
        </label>
        <p className="option-description">データを表形式に自動変換します</p>
      </div>

      <div className="option-item">
        <label className="checkbox">
          <input
            type="checkbox"
            checked={options.mergeData}
            onChange={() => handleChange('mergeData')}
          />
          <span className="checkmark"></span>
          <span>複数ファイルを統合</span>
        </label>
        <p className="option-description">複数ファイルを1つの表に統合します</p>
      </div>

      <div className="option-item">
        <label className="checkbox">
          <input
            type="checkbox"
            checked={options.createChart}
            onChange={() => handleChange('createChart')}
          />
          <span className="checkmark"></span>
          <span>グラフを自動作成</span>
        </label>
        <p className="option-description">データからグラフを生成します</p>
      </div>
    </div>
  );
}

export default OptionPanel;
