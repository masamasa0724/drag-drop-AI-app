import requests
from typing import Dict
from bs4 import BeautifulSoup
import pandas as pd

class URLProcessor:
    """Process data from URLs"""

    @staticmethod
    def process(url: str) -> Dict:
        """
        Process URL content
        
        Args:
            url: URL to process
            
        Returns:
            Dictionary with extracted data
        """
        try:
            headers = {'User-Agent': 'Mozilla/5.0'}
            response = requests.get(url, headers=headers, timeout=10)
            response.encoding = 'utf-8'
            
            # Try to extract tables
            tables = URLProcessor._extract_tables(response.text)
            if tables:
                return tables[0]
            
            # Try to extract structured data
            return URLProcessor._extract_text(response.text)
        except Exception as e:
            return {
                'format': 'url',
                'headers': [],
                'rows': [],
                'error': str(e)
            }

    @staticmethod
    def _extract_tables(html: str) -> list:
        """Extract HTML tables"""
        try:
            tables_list = pd.read_html(html)
            results = []
            
            for table_df in tables_list:
                rows = table_df.where(pd.notna(table_df), None).to_dict('records')
                results.append({
                    'format': 'url_table',
                    'headers': list(table_df.columns),
                    'rows': rows
                })
            
            return results
        except:
            return []

    @staticmethod
    def _extract_text(html: str) -> Dict:
        """Extract text content from HTML"""
        try:
            soup = BeautifulSoup(html, 'html.parser')
            
            # Remove script and style elements
            for script in soup(["script", "style"]):
                script.decompose()
            
            text = soup.get_text()
            lines = [line.strip() for line in text.split('\n') if line.strip()]
            
            from .text_processor import TextProcessor
            return TextProcessor.process('\n'.join(lines))
        except Exception as e:
            return {
                'format': 'url',
                'headers': [],
                'rows': [],
                'error': str(e)
            }
