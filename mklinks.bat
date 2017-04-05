@ECHO OFF
SETLOCAL
ECHO Current directory: %CD%

ECHO Checking input arguments...
IF [%1]==[] (
    ECHO ^<FILESET^> not provided.
    GOTO :USAGE
)
IF [%2]==[] (
    ECHO ^<TARGETDIR^> not provided.
    GOTO :USAGE
)
SET SRCFILES=%1
REM Remove outside quotes
SET SRCFILES=%SRCFILES:"=%
SET TARGETDIR=%2
ECHO Using fileset: %SRCFILES%
ECHO Linking into folder: %TARGETDIR%

ECHO Checking permissions...
NET session >NUL 2>&1
IF %ERRORLEVEL% == 0 (
    ECHO Administrative permissions confirmed.
) ELSE (
    ECHO Current permissions inadequate.
    GOTO USAGE:
)

FOR %%F IN (%SRCFILES%) ^
DO (CALL :HANDLER %%F)
GOTO :EOF

:HANDLER
SET SRCFILE="%CD%\%1"
SET TRGFILE="%TARGETDIR%\%1"
MKDIR %TARGETDIR%
DEL %TRGFILE%
MKLINK %TRGFILE% %SRCFILE%
ECHO Linked %SRCFILE% to  %TRGFILE%
GOTO :EOF

:USAGE
ECHO.
ECHO A convenience script to run multiple MKLINK commands.
ECHO.
ECHO USAGE: %~n0.bat ^<FILESET^> ^<TARGETDIR^>
ECHO.
ECHO ^<FILESET^>   - Files to link, e.g. "*.xml"
ECHO ^<TARGETDIR^> - Target directory for links
ECHO.
ECHO EXAMPLE: %~n0.bat "myfile.txt other.dat" C:\Home\MyFolder
ECHO.
ECHO This is an admin-only script!
ECHO.
PAUSE
EXIT /B 1

:EOF
ENDLOCAL
