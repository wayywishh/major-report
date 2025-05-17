@echo off
setlocal EnableDelayedExpansion

REM === CONFIGURATION ===
set "MAIN_TEX=main.tex"
set "OUTPUT_DIR=outputs"
set "VERSION_FILE=version.txt"

REM === GET DATE ===
for /f %%a in ('powershell -command "Get-Date -Format yyyy-MM-dd"') do set "DATE=%%a"

REM === READ CURRENT VERSION ===
if not exist "%VERSION_FILE%" (
    echo v1 > "%VERSION_FILE%"
)

set /p CURRENT_VERSION=<"%VERSION_FILE%"
set VERSION_NUM=%CURRENT_VERSION:~1%
set /a NEW_VERSION_NUM=VERSION_NUM + 1
set "NEW_VERSION=v!NEW_VERSION_NUM!"

echo %NEW_VERSION% > "%VERSION_FILE%"

REM === CREATE OUTPUT FOLDER ===
set "BUILD_DIR=%OUTPUT_DIR%\report_%CURRENT_VERSION%_%DATE%"
if not exist "%BUILD_DIR%" (
    mkdir "%BUILD_DIR%"
)

REM === COMPILE (requires pdflatex to be in PATH) ===
pdflatex -output-directory="%BUILD_DIR%" "%MAIN_TEX%"
pdflatex -output-directory="%BUILD_DIR%" "%MAIN_TEX%"

REM === DONE ===
if exist "%BUILD_DIR%\main.pdf" (
    echo ✅ Build complete: %BUILD_DIR%\main.pdf
    echo Next version will be: %NEW_VERSION%
) else (
    echo ❌ Build failed.
)
pause
