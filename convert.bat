@echo off
setlocal enabledelayedexpansion
title AVI to MP4 Batch Converter

if not exist "Converted" mkdir "Converted"

set count=0
set done=0

for %%F in (*.avi) do set /a count+=1

if %count%==0 (
    echo No AVI files found in this folder.
    pause
    exit /b
)

echo Found %count% AVI file(s). Starting conversion...
echo.

for %%F in (*.avi) do (
    set /a done+=1
    echo [!done! of !count!] Converting %%F ...
    ffmpeg -y -i "%%F" -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p -c:a aac -b:a 128k -movflags +faststart -loglevel error -stats "Converted\%%~nF.mp4"
    echo.
)

echo ================================
echo ALL FILES FINISHED CONVERTING
echo MP4 files are in the Converted folder
echo ================================
powershell -c "[console]::beep(1000,600)"
pause