# dotfiles

These are my configuration files.

## Linux Install

```bash
curl -fsSL https://raw.githubusercontent.com/chilimangoes/dotfiles/master/linux-install.sh | bash
```

## Windows Install

Paste the following command into a PowerShell terminal running as admin:

```powershell
irm https://raw.githubusercontent.com/chilimangoes/dotfiles/master/windows-install.ps1 | iex
```

Or, download and run [windows-install.ps1](./windows-install.ps1) from an elevated PowerShell terminal.

<details>
<summary>Legacy Windows isntaller (not recommended)</summary>--

Paste the following command into a PowerShell terminal running as admin:

```
$p = Join-Path $env:TEMP 'windows-install.cmd'; `
$u = 'https://raw.githubusercontent.com/chilimangoes/dotfiles/master/windows-install.cmd'; `
Invoke-WebRequest -Uri $u -OutFile $p; `
if ($?) { & cmd.exe /c $p }
```

Or, download and run [windows-install.cmd](./windows-install.cmd) from a terminal as admin.

</details>