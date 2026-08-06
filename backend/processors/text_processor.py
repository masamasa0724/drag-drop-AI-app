import re
from typing import List, Dict

class TextProcessor:
    """Process text files and convert to structured data"""

    @staticmethod
    def process(content: str) -> Dict:
        """
        Process text content and convert to structured format
        
        Args:
            content: Text file content
            
        Returns:
            Dictionary with processed data
        """
        lines = content.strip().split('\n')
        
        # Try to detect format
        if TextProcessor._is_table_format(lines):
            return TextProcessor._parse_table_format(lines)
        elif TextProcessor._is_json_format(content):
            return TextProcessor._parse_json_format(content)
        else:
            return TextProcessor._parse_line_format(lines)

    @staticmethod
    def _is_table_format(lines: List[str]) -> bool:
        """Check if content is in table format (tab or space separated)"""
        if len(lines) < 2:
            return False
        return '\t' in lines[0] or (len(lines[0].split()) > 1 and len(lines[1].split()) > 1)

    @staticmethod
    def _is_json_format(content: str) -> bool:
        """Check if content is in JSON format"""
        try:
            import json
            json.loads(content)
            return True
        except:
            return False

    @staticmethod
    def _parse_table_format(lines: List[str]) -> Dict:
        """Parse table format (tab or space separated)"""
        rows = []
        
        # Detect separator
        separator = '\t' if '\t' in lines[0] else None
        
        for line in lines:
            if not line.strip():
                continue
            parts = line.split(separator) if separator else line.split()
            rows.append(parts)
        
        if len(rows) > 0:
            headers = rows[0]
            data_rows = []
            for row in rows[1:]:
                if len(row) == len(headers):
                    data_rows.append(dict(zip(headers, row)))
            
            return {
                'format': 'table',
                'headers': headers,
                'rows': data_rows
            }
        
        return {'format': 'table', 'headers': [], 'rows': []}

    @staticmethod
    def _parse_json_format(content: str) -> Dict:
        """Parse JSON format"""
        import json
        data = json.loads(content)
        
        if isinstance(data, list):
            if len(data) > 0 and isinstance(data[0], dict):
                headers = list(data[0].keys())
                return {
                    'format': 'json',
                    'headers': headers,
                    'rows': data
                }
        
        return {'format': 'json', 'headers': [], 'rows': []}

    @staticmethod
    def _parse_line_format(lines: List[str]) -> Dict:
        """Parse line format (one item per line)"""
        rows = [{'Item': i+1, 'Content': line.strip()} for i, line in enumerate(lines) if line.strip()]
        return {
            'format': 'line',
            'headers': ['Item', 'Content'],
            'rows': rows
        }
