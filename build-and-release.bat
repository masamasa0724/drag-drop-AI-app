@echo off
REM Build and Release Script for Drag & Drop AI Excel App (Windows batch)

echo =========================================
echo Drag & Drop AI Excel App - Build & Release
echo =========================================
echo.

REM Check if we're in the right directory
if not exist "frontend\package.json" (
    echo Error: frontend\package.json not found
    echo Please run this script from the project root directory
    exit /b 1
)

echo [1/5] Installing frontend dependencies...
cd frontend
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo Error: npm install failed
    exit /b 1
)

echo.
echo [2/5] Building React application...
call npm run build
if %ERRORLEVEL% NEQ 0 (
    echo Error: npm run build failed
    exit /b 1
)

echo.
echo [3/5] Building Windows executable...
call npm run electron-build-win
if %ERRORLEVEL% NEQ 0 (
    echo Error: electron-builder failed
    exit /b 1
)

echo.
echo [4/5] Checking build output...
if exist "dist" (
    echo Build directory found
    echo Files generated:
    dir dist\*.exe /s /b
) else (
    echo Warning: dist directory not found
)

echo.
echo =========================================
echo Build completed successfully!
echo =========================================
echo.
echo Package output files location: frontend\dist\
echo.
echo Next steps:
echo 1. Upload files from frontend\dist\ to GitHub Releases
echo 2. Share the download links with users
echo.
echo To create a GitHub Release:
echo 1. Go to: https://github.com/masamasa0724/drag-drop-AI-app/releases
echo 2. Click 'Draft a new release'
echo 3. Tag version: v0.1.0
echo 4. Upload .exe files from frontend\dist\
echo 5. Publish release
echo.
pause
