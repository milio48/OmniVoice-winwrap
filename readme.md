# OmniVoice Windows Local Installer 🌍

Installer portabel otomatis untuk menjalankan **OmniVoice** (Zero-Shot TTS) di PC Windows tanpa perlu pusing mengatur *environment*. 

Script ini akan secara otomatis mengunduh Python, Git, `uv`, PyTorch, dan model OmniVoice dalam satu folder rapi di Desktop Anda. Semua komponen diisolasi dan tidak akan membebani sistem instalasi utama.

## Cara Install

Pilih **salah satu** metode di bawah ini:

### Metode 1: Instalasi Oneliner (Disarankan)
Buka aplikasi **Windows PowerShell**, *copy-paste* perintah di bawah ini, lalu tekan Enter:

```powershell
irm https://raw.githubusercontent.com/milio48/OmniVoice-winwrap/main/install.ps1 | iex
```

### Metode 2: Klik 2x (.bat)
1. Pergi ke halaman [Releases](https://github.com/milio48/OmniVoice-winwrap/releases/download/v0/install.bat).
2. Download file `install.bat`.
3. Simpan di PC, lalu **klik 2x** file tersebut.
4. Jika muncul peringatan keamanan Windows (SmartScreen), pilih *More info* -> *Run anyway*.

---
**Catatan Penting:** * Saat instalasi pertama kali, proses ini akan memakan waktu cukup lama karena akan mengunduh model PyTorch berukuran besar.
* Folder aplikasi akan otomatis dibuat di `Desktop\OmniVoice-App`. 
* Untuk membuka aplikasi di kemudian hari, cukup buka folder tersebut di Desktop dan klik file `Mulai-OmniVoice.bat`.