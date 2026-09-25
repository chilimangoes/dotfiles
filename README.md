# dotfiles

These are my configuration files.

## Linux Install

```bash
curl -fsSL https://raw.githubusercontent.com/chilimangoes/dotfiles/master/linux-install.sh | bash
```

## Windows Install

Paste the following command into a PowerShell terminal running as admin:

```
$p="$env:TEMP\windows-install.cmd"; curl.exe -fsSL "https://raw.githubusercontent.com/chilimangoes/dotfiles/master/windows-install.cmd" -o $p; if ($LASTEXITCODE -eq 0) { & cmd.exe /c $p }
```

Or, download and run [windows-install.cmd](./windows-install.cmd) from a terminal as admin.