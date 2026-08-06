import base64
from typing import Dict
from PIL import Image
import io
import pytesseract

class ImageProcessor:
    """Process image files (OCR)"""

    @staticmethod
    def process(content: str, filename: str) -> Dict:
        """
        Process image content using OCR
        
        Args:
            content: Base64 encoded image content
            filename: Original filename
            
        Returns:
            Dictionary with extracted text
        """
        try:
            # Decode base64
            image_data = base64.b64decode(content)
            image = Image.open(io.BytesIO(image_data))
            
            # Extract text using OCR
            text = pytesseract.image_to_string(image, lang='jpn+eng')
            
            # Process extracted text as line format
            from .text_processor import TextProcessor
            result = TextProcessor.process(text)
            result['source'] = 'image_ocr'
            result['filename'] = filename
            
            return result
        except Exception as e:
            return {
                'format': 'image',
                'headers': [],
                'rows': [],
                'error': str(e)
            }
