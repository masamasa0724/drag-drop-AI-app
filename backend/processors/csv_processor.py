import csv
import io
from typing import Dict

class CSVProcessor:
    """Process CSV files"""

    @staticmethod
    def process(content: str) -> Dict:
        """
        Process CSV content
        
        Args:
            content: CSV file content
            
        Returns:
            Dictionary with processed data
        """
        try:
            # Try to detect dialect
            sample = content[:1024]
            dialect = csv.Sniffer().sniff(sample)
        except csv.Error:
            dialect = 'excel'
        
        reader = csv.DictReader(io.StringIO(content), dialect=dialect)
        rows = list(reader)
        
        if len(rows) > 0:
            headers = list(rows[0].keys())
            return {
                'format': 'csv',
                'headers': headers,
                'rows': rows
            }
        
        return {'format': 'csv', 'headers': [], 'rows': []}
