@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "GITHUB_REPO=https://github.com/chilimangoes/dotfiles.git"

if not exist "%HOME%" set "HOME=%HOMEDRIVE%%HOMEPATH%"
if not exist "%HOME%" set "HOME=%USERPROFILE%"

set "APP_DIR=%HOME%\dotfiles"
if not exist "%APP_DIR%" (
    git clone "%GITHUB_REPO%" "%APP_DIR%"
) else (
    echo Updating dotfiles
    git -C "%APP_DIR%" pull --ff-only
)

call :link_dotfile "%APP_DIR%\vim\.vimrc" "%HOME%\.vimrc"
call :link_dotfile "%APP_DIR%\vim\.vsvimrc" "%HOME%\.vsvimrc"
call :link_dotfile "%APP_DIR%\git\.gitconfig-aliases" "%HOME%\.gitconfig-aliases"
git config --global include.path "$HOME/.gitconfig-aliases"

pause
goto :eof

:link_dotfile
    set "SOURCE=%~1"
    set "DESTINATION=%~2"

    if exist "%DESTINATION%" (
        for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do set "STAMP=%%I"
        move /Y "%DESTINATION%" "%DESTINATION%.backup-!STAMP!"
    )

    mklink "%DESTINATION%" "%SOURCE%"
    exit /b
