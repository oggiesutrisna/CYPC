# Membungkus ASCII Art Badak agar tidak eror di PowerShell
$Rhino = @"
              _                  __                  
      __.--**"""**--...__..--**""""*-.            
    .'                                 `-.         
  .'                          _           \        
 /                          .'        .    \   _._ 
:                          :         :`*.  :-'.' ;
;    `                     ;          `.) \   /.-' 
:     `                              ; ' -* ;    
       :.    \           :        :  :        :    
 ;     ; `.   `.         ;      ` |  '             
 |         `.             `. -*"*\; /        :     
 |    :     /`-.           `.    \/`.'  _    `.   
 :    ;    :    `*-.__.-*""":`.    \ ;  'o` `. /   
       ;   ;                 ;  \   ;:       ;:   ,/
  |  | |            [bug]      /`  | ,      `*-*'/ 
  `  : :  :                /  /    | : .    ._.-'  
   \  \ ,  \               :   `.   :  \ \   .'     
    :  *:   ;              :    |`*-'   `*+-* `**-*`""                *---*
"@

# Menampilkan badak dan identitas pembuat (Kontras untuk Background Biru)
Clear-Host
Write-Host $Rhino -ForegroundColor White
Write-Host "=====================================================" -ForegroundColor White
Write-Host "===        MEMULAI PEMBERSIHAN ULTIMATE WINDOWS   ===" -ForegroundColor White
Write-Host "===  Created with Love and Gawls by Oggie Sutrisna  ===" -ForegroundColor DarkGray
Write-Host "=====================================================" -ForegroundColor White
Write-Host ""

# 1. Histori Run & Explorer
Write-Host "[-] Membersihkan Histori Run & Explorer..." -ForegroundColor Yellow
$RunPath = "HKCU:\Control Panel\Cursors"
Set-ItemProperty -Path $RunPath -Name "(default)" -Value "Windows Default" -ErrorAction SilentlyContinue
Set-ItemProperty -Path $RunPath -Name "Scheme Name" -Value "Windows Default" -ErrorAction SilentlyContinue

$RunMRU = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
if (Test-Path $RunMRU) { Get-Item -Path $RunMRU | Select-Object -ExpandProperty Property | Where-Object {$_ -ne "(default)"} | ForEach-Object { Remove-ItemProperty -Path $RunMRU -Name $_ -ErrorAction SilentlyContinue } }
$RecentPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths"
if (Test-Path $RecentPath) { Get-Item -Path $RecentPath | Select-Object -ExpandProperty Property | Where-Object {$_ -ne "(default)"} | ForEach-Object { Remove-ItemProperty -Path $RecentPath -Name $_ -ErrorAction SilentlyContinue } }
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Recent\*" -Recurse -Force -ErrorAction SilentlyContinue

# 2. Temporary & Prefetch
Write-Host "[-] Menghapus Temporary & Prefetch Files..." -ForegroundColor Yellow
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue

# 3. Cache Game & GPU (DirectX, NVIDIA, AMD)
Write-Host "[-] Membersihkan Cache Grafik (GPU & DirectX)..." -ForegroundColor Yellow
$DirectXCache = "$env:LOCALAPPDATA\D3DSCache"
if (Test-Path $DirectXCache) { Remove-Item -Path "$DirectXCache\*" -Recurse -Force -ErrorAction SilentlyContinue }
$NvidiaPaths = @("$env:LOCALAPPDATA\NVIDIA\GLCache\*", "$env:LOCALAPPDATA\NVIDIA\DXCache\*", "$env:LOCALAPPDATA\NVIDIA Corporation\NV_Cache\*", "$env:PROGRAMDATA\NVIDIA Corporation\NV_Cache\*")
foreach ($Path in $NvidiaPaths) { if (Test-Path $Path) { Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue } }
$AmdPath = "$env:LOCALAPPDATA\AMD\DxCache\*"
if (Test-Path $AmdPath) { Remove-Item -Path $AmdPath -Recurse -Force -ErrorAction SilentlyContinue }

# 4. Cache Browser (Chrome & Edge)
Write-Host "[-] Membersihkan Cache Browser..." -ForegroundColor Yellow
$ChromeCache = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*"
if (Test-Path $ChromeCache) { Remove-Item -Path $ChromeCache -Recurse -Force -ErrorAction SilentlyContinue }
$EdgeCache = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*"
if (Test-Path $EdgeCache) { Remove-Item -Path $EdgeCache -Recurse -Force -ErrorAction SilentlyContinue }

# 5. System Logs & Delivery Optimization
Write-Host "[-] Membersihkan System Logs & Delivery Optimization..." -ForegroundColor Yellow
Get-ChildItem -Path "C:\Windows" -Filter *.log -Recurse -File -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Panther\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\DeliveryOptimization\*" -Recurse -Force -ErrorAction SilentlyContinue

# 6. MODUL AGRESIF: Sapu Bersih Registry Skema Kursor Kustom (Proteksi Aero Aktif)
Write-Host "[-] Membersihkan Daftar Drop-down Skema Kursor Kustom..." -ForegroundColor Yellow

# PERBAIKAN: Daftar skema bawaan Windows asli (Termasuk variasi AERO) yang HARUS DIPERTAHANKAN
$ProtectedSchemes = @(
    "(default)", "Magnified", 
    "Windows Black", "Windows Black (extra large)", "Windows Black (large)",
    "Windows Default (extra large)", "Windows Default (large)", "Windows Default",
    "Windows Inverted (extra large)", "Windows Inverted (large)", "Windows Inverted",
    "Windows Standard (extra large)", "Windows Standard (large)",
    "Windows Aero", "Windows Aero (extra large)", "Windows Aero (large)"
)

$RegistryPaths = @(
    "HKCU:\Control Panel\Cursors\Schemes",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes"
)

foreach ($RegPath in $RegistryPaths) {
    if (Test-Path $RegPath) {
        $AllSchemes = Get-Item -Path $RegPath | Select-Object -ExpandProperty Property
        foreach ($Scheme in $AllSchemes) {
            if ($ProtectedSchemes -notcontains $Scheme) {
                Remove-ItemProperty -Path $RegPath -Name $Scheme -ErrorAction SilentlyContinue
                Write-Host "    [OK] Hapus Skema Registry: '$Scheme'" -ForegroundColor Green
            }
        }
    }
}

# 7. Hapus Semua Folder Fisik Kursor Kustom di C:\Windows\Cursors
Write-Host "[-] Menghapus Folder Fisik Kursor Kustom..." -ForegroundColor Yellow
$BaseCursorFolder = "C:\Windows\Cursors"
if (Test-Path $BaseCursorFolder) {
    $ProtectedFolders = @("it", "ja-JP", "ko-KR", "zh-CN", "zh-TW")
    $TargetFolders = Get-ChildItem -Path $BaseCursorFolder -Directory
    foreach ($Folder in $TargetFolders) {
        if ($ProtectedFolders -notcontains $Folder.Name) {
            Remove-Item -Path $Folder.FullName -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "    [OK] Hapus Folder Fisik: '$($Folder.Name)'" -ForegroundColor Green
        }
    }
}

# 8. Network & Recycle Bin
Write-Host "[-] Flushing DNS & Emptying Recycle Bin..." -ForegroundColor Yellow
Clear-DnsClientCache
Clear-RecycleBin -Force -Confirm:$false -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "=== PC SEBERSIH CCLEANER & SIAP DIGUNAKAN! ===" -ForegroundColor Green
Write-Host ""

# Menahan jendela terminal agar tidak otomatis menutup
Read-Host -Prompt "Tekan ENTER untuk menutup jendela ini"