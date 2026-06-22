@echo off
setlocal EnableDelayedExpansion
rem ============================================================================
rem  doktor-command.cmd - comando "doktor" para CMD.
rem  Sincroniza uma copia do Doktor System-Design na pasta atual.
rem ============================================================================

for /f %%E in ('echo prompt $E ^| cmd') do set "ESC=%%E"
set "C_INFO=%ESC%[1;36m"
set "C_OK=%ESC%[1;32m"
set "C_ERR=%ESC%[1;31m"
set "C_RESET=%ESC%[0m"

set "REPO_URL=https://github.com/AndreGustavoms/Doktor-System-Design.git"
set "DEST_NAME=Padrao de qualidade - Doktor System-Design"

if /I "%~1"=="-h" goto :help
if /I "%~1"=="--help" goto :help

where git >nul 2>nul
if errorlevel 1 (
  echo %C_ERR%[doktor X]%C_RESET% git nao encontrado no PATH. Instale o Git e tente novamente.
  exit /b 1
)

set "TMP_DIR=%TEMP%\doktor-%RANDOM%%RANDOM%"
set "REPO_TMP=%TMP_DIR%\repo"
mkdir "%TMP_DIR%" 2>nul

echo %C_INFO%[doktor]%C_RESET% Clonando %REPO_URL%
git clone --depth 1 --quiet "%REPO_URL%" "%REPO_TMP%"
if errorlevel 1 (
  echo %C_ERR%[doktor X]%C_RESET% Falha ao clonar. Verifique a conexao e o acesso ao repositorio.
  rmdir /s /q "%TMP_DIR%" 2>nul
  exit /b 1
)

if exist "%REPO_TMP%\.git" rmdir /s /q "%REPO_TMP%\.git"
if not exist "%DEST_NAME%" mkdir "%DEST_NAME%"

echo %C_INFO%[doktor]%C_RESET% Mudancas a aplicar:
robocopy "%REPO_TMP%" "%DEST_NAME%" /MIR /L /FP /NS /NC /NDL /NJH /NJS /NP > "%TMP_DIR%\changes.txt" 2>nul
type "%TMP_DIR%\changes.txt"

echo %C_INFO%[doktor]%C_RESET% Aplicando arquivos...
robocopy "%REPO_TMP%" "%DEST_NAME%" /MIR /NFL /NDL /NJH /NJS /NP >nul
if %ERRORLEVEL% GEQ 8 (
  echo %C_ERR%[doktor X]%C_RESET% Falha ao copiar os arquivos.
  rmdir /s /q "%TMP_DIR%" 2>nul
  exit /b 1
)

rmdir /s /q "%TMP_DIR%" 2>nul
echo %C_OK%[doktor OK]%C_RESET% Concluido em .\%DEST_NAME%
exit /b 0

:help
echo Uso: doktor
echo Sincroniza o Doktor System-Design em ".\%DEST_NAME%".
exit /b 0
