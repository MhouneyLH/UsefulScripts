@echo off

set FOLDER=%1
set REMOTE_NAME=%2

if "%FOLDER%"=="" (
   echo usage: script.bat folderName remoteName
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

echo Creating Remote-Repo...
gh repo create %REMOTE_NAME% --public --source=. --remote=origin
git push origin master
git push origin develop

if %ERRORLEVEL% == 0 (
    echo Script finished OK
    exit /B 0
)

echo Something went wrong, try again
exit /B 1