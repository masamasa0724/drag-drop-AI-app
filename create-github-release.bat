@echo off
REM GitHub Release Creation Script (Windows batch)
REM Requirements: GitHub CLI (gh) must be installed and authenticated
REM Installation: https://cli.github.com/

setlocal enabledelayedexpansion

echo =========================================
echo GitHub Release Creator
echo =========================================
echo.

REM Check if GitHub CLI is installed
where gh >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Error: GitHub CLI ^(gh^) is not installed
    echo.
    echo Install GitHub CLI:
    echo   Windows ^(Chocolatey^): choco install gh
    echo   Windows ^(Scoop^): scoop install gh
    echo   Windows ^(MSI^): https://github.com/cli/cli/releases
    echo.
    echo After installation, run: gh auth login
    pause
    exit /b 1
)

REM Check if authenticated
gh auth status >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Error: Not authenticated with GitHub CLI
    echo.
    echo Run: gh auth login
    pause
    exit /b 1
)

REM Check if we're in the right directory
if not exist "frontend\package.json" (
    echo Error: frontend\package.json not found
    echo Please run this script from the project root directory
    pause
    exit /b 1
)

REM Check if dist directory exists
if not exist "frontend\dist" (
    echo Error: frontend\dist directory not found
    echo Please build the application first using: build-and-release.bat
    pause
    exit /b 1
)

REM Get version from package.json
for /f "delims=" %%A in ('findstr "version" frontend\package.json ^| findstr /V "//"') do (
    set "line=%%A"
    if "!line!" neq "" (
        for /f "tokens=2 delims=:" %%B in ("!line!") do (
            set "temp=%%B"
            for /f "tokens=1 delims=," %%C in ("!temp!") do (
                set "VERSION=%%C"
                set "VERSION=!VERSION:~2,-1!"
            )
        )
        goto :version_found
    )
)

:version_found
set "TAG=v!VERSION!"

echo.
echo Release Information:
echo   Version: !VERSION!
echo   Tag: !TAG!
echo.

REM Check if tag already exists
gh release view "!TAG!" >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo Warning: Release !TAG! already exists
    set /p confirm="Do you want to delete and recreate it? (y/n): "
    if /i "!confirm!"=="y" (
        echo Deleting existing release...
        gh release delete "!TAG!" --yes
    ) else (
        echo Cancelled.
        pause
        exit /b 0
    )
)

echo.
echo Creating GitHub Release...
echo.

echo Uploading files...
for %%F in (frontend\dist\*.exe) do (
    echo   Uploading: %%~nF
)

echo.
echo Creating release with notes...
gh release create "!TAG!" ^
    --title "Drag ^& Drop AI Excel App v!VERSION!" ^
    --notes "Release v!VERSION! of Drag ^& Drop AI Excel App for Windows." ^
    frontend\dist\*.exe

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Release created successfully!
    echo ========================================
    echo.
    echo Release URL: https://github.com/masamasa0724/drag-drop-AI-app/releases/tag/!TAG!
    echo.
    echo Files uploaded:
    for %%F in (frontend\dist\*.exe) do (
        for /f %%S in ('powershell -Command "[math]::Round((Get-Item '%%F').Length/1MB, 1)" 2^>nul') do (
            echo   - %%~nF (%%S MB)
        )
    )
    echo.
    echo Your application is now available for download!
) else (
    echo Error: Failed to create release
)

echo.
pause
