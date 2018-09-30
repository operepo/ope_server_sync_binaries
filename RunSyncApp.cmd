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
%~dp0\bin\bin\git.exe remote remove ope_origin
%~dp0\bin\bin\git.exe remote add ope_origin https://github.com/operepo/ope_server_sync_binaries.git
%~dp0\bin\bin\git.exe remote update
%~dp0\bin\bin\git.exe checkout master
rem %~dp0\bin\bin\git.exe pull ope_origin master

cd %~dp0SyncApp
echo %cd%
SyncApp.exe

