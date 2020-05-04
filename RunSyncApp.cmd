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

echo %ESC_GREEN% --- Ensuring you have the latest version of the app --- %ESC_RESET%

call %~dp0PullUpdates.cmd


cd %~dp0SyncApp
echo %cd%
SyncApp.exe

