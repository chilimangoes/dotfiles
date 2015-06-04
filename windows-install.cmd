
@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_DIR=%HOME%\dotfiles
IF NOT EXIST "%APP_DIR%" (
    call git clone --recursive https://github.com/chilimangoes/dotfiles.git "%APP_DIR%"
) ELSE (
	@set ORIGINAL_DIR=%CD%
    echo updating dotfiles
    chdir /d "%APP_DIR%" 
	call git pull
    chdir /d "%ORIGINAL_DIR%"
	call cd "%APP_DIR%" 
)

call mklink "%HOME%\.vimrc" "%APP_DIR%\vim\.vimrc"
call mklink "%HOME%\.vsvimrc" "%APP_DIR%\vim\.vsvimrc"

