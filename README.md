# CYPC

CYPC is a Windows PowerShell cleanup script designed to remove common system clutter, temporary files, cache data, and leftover custom cursor entries from a Windows PC.

The script provides a simple terminal-based cleanup flow with status messages for each step. It focuses on clearing files and settings that can safely build up over time, including temporary folders, browser cache, GPU shader cache, Windows logs, DNS cache, and Recycle Bin contents.

## Features

- Clears Windows temporary files from user and system temp folders.
- Removes Prefetch files.
- Clears DirectX, NVIDIA, and AMD graphics cache folders.
- Clears Google Chrome and Microsoft Edge cache folders.
- Removes selected Windows log files and Delivery Optimization data.
- Clears Run history, Explorer typed paths, and recent files.
- Resets the cursor scheme to the Windows default.
- Removes custom cursor schemes while preserving built-in Windows cursor schemes.
- Deletes custom cursor folders from `C:\Windows\Cursors` while preserving protected language folders.
- Flushes the DNS client cache.
- Empties the Recycle Bin.

## Requirements

- Windows
- PowerShell
- Administrator privileges are recommended because several cleanup targets are located under protected system directories such as `C:\Windows`.

## Usage

1. Download or clone this repository.
2. Open PowerShell as Administrator.
3. Run the script:

```powershell
.\CYPC.ps1
```

If PowerShell blocks the script because of your execution policy, run it with:

```powershell
powershell -ExecutionPolicy Bypass -File .\CYPC.ps1
```

## Important Notes

This script deletes cache files, temporary files, recent file history, Recycle Bin contents, custom cursor registry entries, and custom cursor folders. Review the script before running it if you have custom cursor packs or cached data that you want to keep.

Some operations may fail silently if a file is in use or if PowerShell does not have enough permissions. Running PowerShell as Administrator gives the script the best chance of completing all cleanup steps.

## Author

Created by Oggie Sutrisna.
