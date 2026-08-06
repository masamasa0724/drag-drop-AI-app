from flask import Flask, request, jsonify, send_file
from flask_cors import CORS
import os
import base64
from config import config_by_name
from processors import TextProcessor, CSVProcessor, ImageProcessor, URLProcessor
from excel_generator import ExcelGenerator
import json

app = Flask(__name__)
CORS(app)

# Load configuration
env = os.getenv('FLASK_ENV', 'dev')
app.config.from_object(config_by_name[env])

# Create folders
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
os.makedirs(app.config['OUTPUT_FOLDER'], exist_ok=True)


@app.route('/api/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({'status': 'ok', 'message': 'Backend is running'})


@app.route('/api/process', methods=['POST'])
def process_files():
    """
    Process uploaded files
    
    Expected JSON:
    {
        "files": [
            {"name": "file.txt", "type": "text/plain", "content": "..."}
        ],
        "options": {
            "autoFormat": true,
            "createChart": false,
            "mergeData": false
        }
    }
    """
    try:
        data = request.json
        files = data.get('files', [])
        options = data.get('options', {})
        
        if not files:
            return jsonify({'error': 'No files provided'}), 400
        
        # Process each file
        processed_data = []
        for file_data in files:
            file_name = file_data.get('name', '')
            file_type = file_data.get('type', '')
            content = file_data.get('content', '')
            
            result = process_single_file(file_name, file_type, content)
            if result:
                processed_data.append(result)
        
        # Merge data if requested
        if options.get('mergeData') and len(processed_data) > 1:
            processed_data = [merge_data(processed_data)]
        
        return jsonify({
            'success': True,
            'data': processed_data[0] if len(processed_data) == 1 else processed_data
        })
    except Exception as e:
        print(f"Error in process_files: {e}")
        return jsonify({'error': str(e)}), 500


@app.route('/api/export', methods=['POST'])
def export_excel():
    """
    Export processed data to Excel
    
    Expected JSON:
    {
        "data": {...},
        "savePath": "C:\\path\\to\\file.xlsx"
    }
    """
    try:
        request_data = request.json
        data = request_data.get('data')
        save_path = request_data.get('savePath')
        
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        if not save_path:
            return jsonify({'error': 'No save path provided'}), 400
        
        # Generate Excel
        generator = ExcelGenerator()
        data_list = data if isinstance(data, list) else [data]
        generator.generate(data_list, save_path)
        
        return jsonify({
            'success': True,
            'message': f'Excel file created: {save_path}'
        })
    except Exception as e:
        print(f"Error in export_excel: {e}")
        return jsonify({'error': str(e)}), 500


def process_single_file(filename: str, file_type: str, content: str) -> dict:
    """
    Process a single file based on its type
    """
    try:
        # Determine file type
        if 'csv' in filename.lower() or 'text/csv' in file_type:
            return CSVProcessor.process(content)
        elif 'text' in file_type or filename.endswith('.txt'):
            return TextProcessor.process(content)
        elif 'image' in file_type or any(filename.endswith(ext) for ext in ['.png', '.jpg', '.jpeg', '.gif']):
            return ImageProcessor.process(content, filename)
        elif filename.startswith('http://') or filename.startswith('https://'):
            return URLProcessor.process(filename)
        else:
            # Default to text processor
            return TextProcessor.process(content)
    except Exception as e:
        print(f"Error processing {filename}: {e}")
        return None


def merge_data(data_list: list) -> dict:
    """
    Merge multiple processed data into one
    """
    all_rows = []
    all_headers = set()
    
    for data in data_list:
        headers = data.get('headers', [])
        rows = data.get('rows', [])
        all_headers.update(headers)
        all_rows.extend(rows)
    
    return {
        'format': 'merged',
        'headers': list(all_headers),
        'rows': all_rows
    }


if __name__ == '__main__':
    app.run(
        host=app.config['HOST'],
        port=app.config['PORT'],
        debug=app.config['DEBUG']
    )
