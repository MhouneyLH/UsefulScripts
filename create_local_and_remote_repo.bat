@echo off

rem folder of git-repo
set FOLDER=%1
rem name of the remote-repo
set REMOTE_NAME=%2
rem wether the repo is public or not
set PRIVACY_MODE=%3

if "%FOLDER%"=="" (
   echo usage: script.bat folderName remoteName privacyMode "('pri' - private; 'pub' - public)"
   pause
   exit
)
cd %FOLDER%

git init
git add -A
git commit -m "Initial commit"

git branch develop
git switch develop

if "%REMOTE_NAME%"=="" (
   for /f %%q in ("%FOLDER%") do (
      set REMOTE_NAME=%%~nxq
   )
   echo REMOTE_NAME now set to "!REMOTE_NAME!"
)

if "%PRIVACY_MODE%"=="pri" (set PRIVACY_MODE=private) else (set PRIVACY_MODE=public)

echo Creating Remote-Repo...
gh repo create %REMOTE_NAME% --"%PRIVACY_MODE%" --source=. --remote=origin
git push origin master
git push origin develop

if %ERRORLEVEL% == 0 (
    echo Script finished OK
    exit /B 0
)

echo Something went wrong, try again
exit /B 1