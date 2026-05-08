@echo off
setlocal EnableExtensions EnableDelayedExpansion
pushd "%~dp0"
title UF AmadeusGPT - Installation and Setup

echo             __
echo        -. (#)(#) .-
echo         '\.';;'./'
echo      .-\.'  ;;  './-.
echo        ;    ;;    ;
echo        ;   .''.   ;
echo         '''    '''

echo =================================
echo  UF Laboratory Setup and Linker
echo =================================

:: ===================================================
:: 1. SYSTEM DEPENDENCY CHECK
:: ===================================================

:: Git Check
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [+] Installing Git...
    winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
    set "PATH=%PATH%;C:\Program Files\Git\cmd"
)

:: uv Check
where uv >nul 2>nul
if %errorlevel% neq 0 (
    echo [+] Installing uv...
    powershell -ExecutionPolicy Bypass -c "irm https://astral.sh/uv/install.ps1 | iex"
    set "PATH=%PATH%;%USERPROFILE%\.cargo\bin"
)

:: ===================================================
:: 2. PROJECT REPOSITORY SETUP
:: ===================================================

if exist AmadeusGPT_Source\amadeusgpt\app.py goto :SKIP_CLONE

echo [+] Cloning repository...
git clone https://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@github.com/D3V-D/AmadeusGPT-UF.git AmadeusGPT_Source

:SKIP_CLONE
echo [+] Repository verified.

:: ===================================================
:: 3. DESKTOP SHORTCUT CREATOR
:: ===================================================

set "SHORTCUT_PATH=%USERPROFILE%\Desktop\UF AmadeusGPT.lnk"
set "TARGET_BAT=%CD%\AmadeusGPT_Source\launch.bat"
set "ICON_PATH=%CD%\AmadeusGPT_Source\static\favicon.ico"

echo [+] Linking Desktop Shortcut to Repository Launch Script...

:: Create the shortcut using PowerShell
powershell -ExecutionPolicy Bypass -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%SHORTCUT_PATH%'); $s.TargetPath='%TARGET_BAT%'; $s.WorkingDirectory='%CD%\AmadeusGPT_Source'; if (Test-Path '%ICON_PATH%') { $s.IconLocation='%ICON_PATH%' } else { $s.IconLocation='C:\Windows\System32\shell32.dll, 22' }; $s.Save()"

echo.
echo =====================================================
echo  AmadeusGPT successfully installed!
echo  A shortcut has been created on your Desktop.
echo  Click on this shortcut to launch AmadeusGPT locally.
echo  -
echo  IMPORTANT: If you want to move where your AmadeusGPT
echo  folder is located, then delete your current one and
echo  run this installer where you want AmadeusGPT.
echo  Otherwise, the desktop shortcut will not work.
echo =====================================================
pause
popd
