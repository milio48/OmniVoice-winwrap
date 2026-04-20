@echo off
title OmniVoice Auto Installer
echo ===================================================
echo   Memulai Installer OmniVoice...
echo   Silakan klik "Yes" jika muncul pop-up Administrator.
echo ===================================================

:: Memanggil oneliner PowerShell secara otomatis dari raw GitHub
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/milio48/OmniVoice-winwrap/main/install.ps1 | iex"

exit