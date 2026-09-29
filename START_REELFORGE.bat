@echo off
setlocal
cd /d "%~dp0"
if not exist "backend\.venv\Scripts\python.exe" (
  echo Backend environment missing. Follow backend\README.md to install dependencies.
  pause
  exit /b 1
)
"backend\.venv\Scripts\python.exe" -m backend.launcher %*
if errorlevel 1 pause
