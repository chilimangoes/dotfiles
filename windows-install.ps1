$ErrorActionPreference = 'Stop'

$githubRepo = 'https://github.com/chilimangoes/dotfiles.git'
$appDir = Join-Path $HOME 'dotfiles'

function Link-Dotfile {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (Test-Path -LiteralPath $Destination) {
        if ((Get-Item -LiteralPath $Destination).LinkType) {
            Remove-Item -LiteralPath $Destination -Force
        }
        else {
            Move-Item -LiteralPath $Destination -Destination "$Destination.backup-$(Get-Date -Format yyyyMMddHHmmss)"
        }
    }

    New-Item -ItemType SymbolicLink -Path $Destination -Target $Source | Out-Null
}

if (Test-Path -LiteralPath $appDir) {
    Write-Host 'Updating dotfiles'
    git -C $appDir pull --ff-only
}
else {
    git clone $githubRepo $appDir
}

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Link-Dotfile (Join-Path $appDir 'vim\.vimrc') (Join-Path $HOME '.vimrc')
Link-Dotfile (Join-Path $appDir 'vim\.vsvimrc') (Join-Path $HOME '.vsvimrc')
Link-Dotfile (Join-Path $appDir 'git\.gitconfig-aliases') (Join-Path $HOME '.gitconfig-aliases')

git config --global include.path '~/.gitconfig-aliases'
