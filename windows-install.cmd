@echo off

set GITHUB_REPO=https://github.com/chilimangoes/dotfiles.git

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

pause
