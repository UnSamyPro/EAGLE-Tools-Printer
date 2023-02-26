:: MIT License
:: 
:: Copyright (c) 2023 SamyPro (Samuel Prossliner)
:: 
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:
:: 
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
:: 
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

@ECHO OFF

SET originalFolder=%CD%
SET FOLDER=%EAGLE_PATH%

IF DEFINED EAGLE_PATH (
    ECHO EAGLE_PATH environment variable found...

    ECHO Checking for EAGLE executable...
    IF EXIST "%FOLDER%\bin\eagle.exe" (
        ECHO EAGLE executable found...
        ECHO.
    ) ELSE (
        ECHO EAGLE executable not found.
        ECHO Please select the correct directory.
        ECHO.
        GOTO select_directory
        PAUSE
        EXIT /B
    )

    GOTO program_start
) ELSE (
    ECHO EAGLE_PATH environment variable not found...
    GOTO select_directory
)
PAUSE
EXIT /B



:select_directory
ECHO Select EAGLE installation directory...
ECHO.

SET "PScommand="POWERSHELL Add-Type -AssemblyName System.Windows.Forms; $FolderBrowse = New-Object System.Windows.Forms.OpenFileDialog -Property @{ValidateNames = $false;CheckFileExists = $false;RestoreDirectory = $true;FileName = 'Select directory';Title = 'Select EAGLE installation directory';};$result = $FolderBrowse.ShowDialog();$FolderName = Split-Path -Path $FolderBrowse.FileName;Write-Output $result;If ($result -ne 'OK') {Write-Output ''} Else {Write-Output $FolderName};""
FOR /F "usebackq tokens=*" %%Q in (`%PScommand%`) DO (
    SET FOLDER=%%Q
)
SET PScommand=
:: for fucks sake; why does an empty %FOLDER% variable sometimes contain a $ sign? ... I hate windows
IF "%FOLDER%"=="Cancel" (
    ECHO No directory selected.
    ECHO Please select the correct directory.
    ECHO.
    SET FOLDER=
    PAUSE
    EXIT /B
    goto:eof
)

ECHO Selected directory: %FOLDER%
ECHO.

ECHO Checking for EAGLE executable...
IF EXIST "%FOLDER%\bin\eagle.exe" (
    ECHO EAGLE executable found...
    ECHO.
) ELSE (
    ECHO EAGLE executable not found.
    ECHO Please select the correct directory.
    ECHO.
    SET FOLDER=
    PAUSE
    EXIT /B
    goto:eof
)

ECHO Setting EAGLE_PATH environment variable...
SETX EAGLE_PATH "%FOLDER%"
SET EAGLE_PATH=%FOLDER%
ECHO EAGLE_PATH set to %FOLDER%
goto program_start



:program_start
:: get version
ECHO Getting latest version...
SET getVersion= "curl -s -L https://api.github.com/repos/UnSamyPro/EAGLE-Tools-Printer/releases/latest | Find "tag_name""
FOR /F "usebackq tokens=*" %%F in (`%getVersion%`) DO (
    SET releaseVersionLine=%%F
)
SET getVersion=
SET version=%releaseVersionLine:~13,-2%
SET releaseVersionLine=
SET filename=EAGLE-Tools-Printer-%version:~1%
ECHO Latest version: %version%
ECHO filename: %filename%

:: cd to temp folder and make subfolder
CD %temp%
MKDIR EAGLE-Tools-Printer-%version:~1%_temp
CD EAGLE-Tools-Printer-%version:~1%_temp

ECHO Downloading latest version...
:: download the zip file
SET downloadCmd="curl -L -o %filename%.zip https://github.com/UnSamyPro/EAGLE-Tools-Printer/archive/%version%.zip"
FOR /F "usebackq tokens=*" %%F in (`%downloadCmd%`) DO (
    SET downloadLocation=%%F
)
SET downloadLocation=
SET downloadCmd=

ECHO Installing latest version...
:: unzip the file
SET unzipCmd="tar -xvf %filename%.zip"
FOR /F "usebackq tokens=*" %%F in (`%unzipCmd%`) DO (
    SET unzipLocation=%%F
)
SET unzipCmd=

ECHO Installing files...
:: move the files to the correct location
CD %filename%\src
MOVE /Y "_EAGLE-Tools_cam2print.ulp" "%FOLDER%\ulp"
MOVE /Y "_EAGLE-Tools-Printer.ulp" "%FOLDER%\ulp"
MOVE /Y "eagle.scr" "%FOLDER%\scr"
MOVE /Y "cam\\_Bestueckungsseite_Film.cam" "%FOLDER%\cam"
MOVE /Y "cam\\_Bestueckungsseite.cam" "%FOLDER%\cam"
MOVE /Y "cam\\_Leiterbahnseite_Film.cam" "%FOLDER%\cam"
MOVE /Y "cam\\_Leiterbahnseite.cam" "%FOLDER%\cam"
MOVE /Y "cam\\_Schaltplan.cam" "%FOLDER%\cam"

ECHO Cleaning up...
:: delete the temp folder
CD %temp%
RMDIR /S /Q EAGLE-Tools-Printer-%version:~1%_temp

ECHO.
ECHO.
ECHO +-----------------------------------------------+
ECHO ^| Installation complete.                        ^|
ECHO ^| Please restart EAGLE to use the new features. ^|
ECHO +-----------------------------------------------+
ECHO.
ECHO.

:: cd back to original folder
CD %originalFolder%
SET originalFolder=
SET FOLDER=
SET version=
SET filename=
goto:eof



PAUSE
EXIT /B