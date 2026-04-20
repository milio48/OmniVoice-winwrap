# ==========================================
# SCRIPT INSTALLER & LAUNCHER OMNIVOICE
# URL: https://github.com/milio48/OmniVoice-winwrap
# ==========================================
$ScriptUrl = "https://raw.githubusercontent.com/milio48/OmniVoice-winwrap/main/install.ps1"

# ==========================================
# 1. CEK DAN MINTA AKSES ADMINISTRATOR
# ==========================================
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-Not $isAdmin) {
    Write-Host "Meminta izin Administrator untuk melanjutkan instalasi..." -ForegroundColor Yellow
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm $ScriptUrl | iex`""
    Exit
}

# ==========================================
# 2. PERSIAPAN FOLDER INSTALASI
# ==========================================
$InstallPath = Join-Path $HOME "Desktop\OmniVoice-App"

if (-Not (Test-Path $InstallPath)) {
    New-Item -ItemType Directory -Path $InstallPath | Out-Null
}
Set-Location $InstallPath
Write-Host "--- Memulai Setup OmniVoice di: $InstallPath ---" -ForegroundColor Cyan

# ==========================================
# 3. PENGECEKAN & INSTALASI DEPENDENSI
# ==========================================

# Cek Git
if (Get-Command "git" -ErrorAction SilentlyContinue) {
    Write-Host "[OK] Git sudah terinstall." -ForegroundColor Green
} else {
    Write-Host "[WAIT] Git belum ada. Menginstal via Winget..." -ForegroundColor Yellow
    winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements --silent
}

# Cek Python
if (Get-Command "python" -ErrorAction SilentlyContinue) {
    Write-Host "[OK] Python sudah terinstall." -ForegroundColor Green
} else {
    Write-Host "[WAIT] Python belum ada. Menginstal Python 3.11 via Winget..." -ForegroundColor Yellow
    winget install --id Python.Python.3.11 -e --accept-package-agreements --accept-source-agreements --silent
}

# Refresh PATH sistem sementara
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Cek uv
if (Get-Command "uv" -ErrorAction SilentlyContinue) {
    Write-Host "[OK] uv (Package Manager) sudah terinstall." -ForegroundColor Green
} else {
    Write-Host "[WAIT] uv belum ada. Menginstal uv..." -ForegroundColor Yellow
    Invoke-RestMethod -Uri https://astral.sh/uv/install.ps1 | Invoke-Expression
    $env:Path += ";$HOME\.cargo\bin"
}

# ==========================================
# 4. CLONE & SETUP OMNIVOICE
# ==========================================

# Cek Folder Repo
if (Test-Path "OmniVoice") {
    Write-Host "[OK] Source code OmniVoice sudah ada." -ForegroundColor Green
} else {
    Write-Host "[WAIT] Mengunduh source code OmniVoice..." -ForegroundColor Yellow
    git clone https://github.com/k2-fsa/OmniVoice.git
}
Set-Location "OmniVoice"

Write-Host "Menyinkronkan environment dan model AI (uv sync)..." -ForegroundColor Cyan
uv sync

# ==========================================
# 5. PEMBUATAN LAUNCHER (.bat)
# ==========================================
$BatPath = Join-Path $InstallPath "Mulai-OmniVoice.bat"
if (-Not (Test-Path $BatPath)) {
    $BatContent = @"
@echo off
cd /d "%~dp0OmniVoice"
echo Menjalankan OmniVoice Local Server...
start http://127.0.0.1:8001
..\uv.exe run omnivoice-demo --ip 127.0.0.1 --port 8001
pause
"@
    $BatContent | Out-File -FilePath $BatPath -Encoding ASCII
}

Write-Host "------------------------------------------------" -ForegroundColor Green
Write-Host "INSTALASI SELESAI!" -ForegroundColor Green
Write-Host "Silakan jalankan file 'Mulai-OmniVoice.bat' di folder OmniVoice-App pada Desktop kamu."
Write-Host "------------------------------------------------" -ForegroundColor Green

# Menjalankan untuk pertama kalinya
start http://127.0.0.1:8001
uv run omnivoice-demo --ip 127.0.0.1 --port 8001