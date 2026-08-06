@echo off
REM Windows build script for Drag & Drop AI Excel App

echo =========================================
echo Drag & Drop AI Excel App - Windows Build
echo =========================================
echo.

echo [1/4] Installing dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo Error: npm install failed
    exit /b 1
)

echo.
echo [2/4] Building React app...
call npm run build
if %ERRORLEVEL% NEQ 0 (
    echo Error: npm run build failed
    exit /b 1
)

echo.
echo [3/4] Building Windows application...
echo Select build type:
echo   1 = Portable EXE (portable.exe)
echo   2 = NSIS Installer (Setup.exe)
echo.
set /p choice="Enter choice (1 or 2): "

if "%choice%"=="1" (
    echo Building portable EXE...
    call npx electron-builder --win portable
) else if "%choice%"=="2" (
    echo Building NSIS installer...
    call npx electron-builder --win nsis
) else (
    echo Invalid choice. Building both formats...
    call npx electron-builder --win
)

if %ERRORLEVEL% NEQ 0 (
    echo Error: electron-builder failed
    exit /b 1
)

echo.
echo [4/4] Build complete!
echo.
echo Output files location: dist/
echo.
echo =========================================
echo Build successful!
echo =========================================
pause
