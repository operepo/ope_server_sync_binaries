@echo off
cd %~dp0

rem Try and update from online or offline server

echo checking for local git repo...
if EXIST .git (
  echo "Git repo exists..."
) ELSE (
  echo "Git repo missing, init new repo..."
  %~dp0\bin\bin\git.exe init
  %~dp0\bin\bin\git.exe add .  
  
)

echo Ensuring you have the latest version of the app...

echo checking online for updates...

echo Updating OPE Code...
call %~dp0PullUpdates.cmd


cd %~dp0SyncApp
echo %cd%
SyncApp.exe

