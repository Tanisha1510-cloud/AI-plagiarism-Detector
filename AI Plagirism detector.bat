
@echo off
setlocal

title AI Plagiarism Detector
color 0B

echo.
echo ==========================================
echo        AI PLAGIARISM DETECTOR
echo ==========================================
echo.

REM Move to the project directory
cd /d "%~dp0"

REM Check Java
echo Checking Java installation...
java -version

if errorlevel 1 (
    echo ERROR: Java is not installed or configured.
    goto ERROR_EXIT
)

REM Check Maven
echo.
echo Checking Maven installation...
call mvn -version

if errorlevel 1 (
    echo ERROR: Maven is not installed or configured.
    goto ERROR_EXIT
)

REM Ask for Brave API key if required
if not defined BRAVE_API_KEY (
    echo.
    echo Brave API key is not configured.
    echo Leave blank to use local detection only.
    set /p "BRAVE_API_KEY=Enter Brave API key: "
)

echo.
echo ==========================================
echo        BUILDING APPLICATION
echo ==========================================
echo.

call mvn clean compile

if errorlevel 1 (
    echo.
    echo ERROR: Project compilation failed.
    goto ERROR_EXIT
)

echo.
echo ==========================================
echo        STARTING APPLICATION
echo ==========================================
echo.

call mvn exec:java

if errorlevel 1 (
    echo.
    echo ERROR: Application could not start.
    goto ERROR_EXIT
)

echo.
echo ==========================================
echo        APPLICATION CLOSED
echo ==========================================

goto NORMAL_EXIT

:ERROR_EXIT
echo.
echo Please check the error messages above.
echo The launcher will remain open.
pause
exit /b 1

:NORMAL_EXIT
echo.
pause
exit /b 0
