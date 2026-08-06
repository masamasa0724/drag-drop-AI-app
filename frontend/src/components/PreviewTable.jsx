import React from 'react';
import './PreviewTable.css';

function PreviewTable({ data }) {
  if (!data || !data.rows || data.rows.length === 0) {
    return <div className="preview-empty">プレビュー: データなし</div>;
  }

  const headers = Object.keys(data.rows[0]);
  const rows = data.rows.slice(0, 20); // Show first 20 rows

  return (
    <div className="preview-container">
      <h2>📊 プレビュー</h2>
      <div className="table-wrapper">
        <table className="preview-table">
          <thead>
            <tr>
              {headers.map((header) => (
                <th key={header}>{header}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {rows.map((row, idx) => (
              <tr key={idx}>
                {headers.map((header) => (
                  <td key={`${idx}-${header}`}>{row[header] || '-'}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      {data.rows.length > 20 && (
        <p className="table-info">最初の20行を表示中... (全{data.rows.length}行)</p>
      )}
    </div>
  );
}

export default PreviewTable;
