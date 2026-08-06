import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    """Base configuration"""
    FLASK_ENV = os.getenv('FLASK_ENV', 'development')
    DEBUG = os.getenv('FLASK_DEBUG', True)
    PORT = int(os.getenv('PORT', 5000))
    HOST = os.getenv('HOST', 'localhost')
    MAX_UPLOAD_SIZE = int(os.getenv('MAX_UPLOAD_SIZE', 50000000))
    ALLOWED_EXTENSIONS = os.getenv('ALLOWED_EXTENSIONS', 'txt,csv,xlsx,png,jpg,jpeg,gif').split(',')
    UPLOAD_FOLDER = os.path.join(os.path.dirname(__file__), 'uploads')
    OUTPUT_FOLDER = os.path.join(os.path.dirname(__file__), 'output')

class DevelopmentConfig(Config):
    """Development configuration"""
    DEBUG = True
    TESTING = False

class ProductionConfig(Config):
    """Production configuration"""
    DEBUG = False
    TESTING = False

class TestingConfig(Config):
    """Testing configuration"""
    DEBUG = True
    TESTING = True

config_by_name = dict(
    dev=DevelopmentConfig,
    prod=ProductionConfig,
    test=TestingConfig
)
