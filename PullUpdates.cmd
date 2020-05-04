@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

SET ESC=[
SET ESC_CLEAR=%ESC%2j
SET ESC_RESET=%ESC%0m
SET ESC_GREEN=%ESC%32m
SET ESC_RED=%ESC%31m
SET ESC_YELLOW=%ESC%33m

cd %~dp0
rem echo %~dp0

rem echo checking for local git repo...
if EXIST .git (
  rem echo "Git repo exists..."
) ELSE (
  echo %ESC_GREEN% Initilizing Local Git Repo...
  %~dp0\bin\bin\git.exe init  >> nul 2>&1
  %~dp0\bin\bin\git.exe add . >> nul 2>&1
)

echo %ESC_GREEN%Updating SyncApp to the latest update...%ESC_RESET%

rem Add the online origin
%~dp0\bin\bin\git.exe remote remove ope_origin >> nul 2>&1
%~dp0\bin\bin\git.exe remote add ope_origin https://github.com/operepo/ope_server_sync_binaries.git >> nul 2>&1

rem Add the offline origin
%~dp0\bin\bin\git.exe remote remove ope_smc_origin >> nul 2>&1
%~dp0\bin\bin\git.exe remote add ope_smc_origin git://smc.ed/ope_server_sync_binaries.git >> nul 2>&1

rem Which origin were we able to pull from?
SET PULL_ORIGIN=ope_origin

rem Try to pull the online origin
echo %ESC_GREEN%trying online git pull...%ESC_RESET%
%~dp0\bin\bin\git.exe pull !PULL_ORIGIN! master >> nul 2>&1

if !ERRORLEVEL! NEQ 0 (
    rem Failed to pull from the 
    echo.
    echo.
    echo %ESC_YELLOW%Online pull failed, pulling from local smc server%ESC_RESET%
    echo.
    
    rem SET PULL_ORIGIN=ope_smc_origin
    rem %~dp0\bin\bin\git.exe pull !PULL_ORIGIN! master >> nul 2>&1
    
    rem if !ERRORLEVEL! NEQ 0 (
    rem     echo.
    rem     echo.
    rem     echo %ESC_RED%***** Failed to git pull from local SMC server, You may not have the latest SyncApp *****%ESC_RESET%
    rem     echo.
    rem     rem echo !PULL_ORIGIN!
    rem ) else (
    rem     echo %ESC_GREEN%-- Updated from local SMC server.%ESC_RESET%
    rem )
) else (
    echo %ESC_GREEN%-- Updated from online github server.%ESC_RESET%
    
)

rem Force us to the current HEAD (force us to update)
echo %ESC_GREEN%Checking out changes...%ESC_RESET%
%~dp0\bin\bin\git.exe checkout master >> nul 2>&1
%~dp0\bin\bin\git.exe rebase !PULL_ORIGIN!/master >> nul 2>&1
if !ERRORLEVEL! NEQ 0 (
    echo.
    echo.
    echo %ESC_RED%***** Error during rebase! You have local changes - SyncApp NOT Updated. *****%ESC_RESET%
    echo.
) else (
    echo %ESC_GREEN%SyncApp Update Finished!%ESC_RESET%
)
