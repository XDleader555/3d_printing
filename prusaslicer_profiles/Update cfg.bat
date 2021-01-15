@echo off
@pushd "%~dp0"
cls
setlocal

SET SRC_DIR="Prusa_MK2"
SET DEST_DIR="%USERPROFILE%\AppData\Roaming\PrusaSlicer\"

:PROMPT
echo Running this updater will delete all existing printer configs.
echo Snapshots will not be touched.
SET /P AREYOUSURE=Are you sure you want to continue? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

echo Updating Prusa Slicer configs...
tasklist | find /i "prusa-slicer.exe" && taskkill /im prusa-slicer.exe /F || echo process "prusa-slicer.exe" not running.

IF NOT EXIST "%USERPROFILE%\AppData\Roaming\PrusaSlicer" GOTO COPYCFG
@RD /S /Q "%USERPROFILE%\AppData\Roaming\PrusaSlicer\filament"
@RD /S /Q "%USERPROFILE%\AppData\Roaming\PrusaSlicer\print"
@RD /S /Q "%USERPROFILE%\AppData\Roaming\PrusaSlicer\printer"
@RD /S /Q "%USERPROFILE%\AppData\Roaming\PrusaSlicer\vendor"

:COPYCFG
xcopy /E /Y %SRC_DIR% %DEST_DIR%

echo Done

:END
@pause