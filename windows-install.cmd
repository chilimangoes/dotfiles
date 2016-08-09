@echo off

set GITHUB_REPO=https://github.com/chilimangoes/dotfiles.git
set CONEMU_DIR=C:\Program Files\ConEmu

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_DIR=%HOME%\dotfiles
IF NOT EXIST "%APP_DIR%" (
    call git clone --recursive %GITHUB_REPO% "%APP_DIR%"
) ELSE (
	@set ORIGINAL_DIR=%CD%
    echo updating dotfiles
    chdir /d "%APP_DIR%" 
	call git pull
    chdir /d "%ORIGINAL_DIR%"
	call cd "%APP_DIR%" 
)

if exist "%HOME%\.vimrc" del "%HOME%\.vimrc"
call mklink "%HOME%\.vimrc" "%APP_DIR%\vim\.vimrc"

if exist "%HOME%\.vsvimrc" del "%HOME%\.vsvimrc"
call mklink "%HOME%\.vsvimrc" "%APP_DIR%\vim\.vsvimrc"

if exist "%CONEMU_DIR%\ConEmu.xml" del "%CONEMU_DIR%\ConEmu.xml"
call mklink "%CONEMU_DIR%\ConEmu.xml" "%APP_DIR%\ConEmu\ConEmu.xml"

if exist "%CONEMU_DIR%\conemu_startup.txt" del "%CONEMU_DIR%\conemu_startup.txt"
call mklink "%CONEMU_DIR%\conemu_startup.txt" "%APP_DIR%\ConEmu\conemu_startup.txt"
