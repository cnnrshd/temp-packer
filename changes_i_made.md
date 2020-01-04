## provisioners
### Changed
#### This
```
"execute_command": "{{ .Vars }} cmd /c \"{{ .Path }}\"",
"remote_path": "/tmp/script.bat",
"scripts": [
	"./scripts/pin-powershell.bat",
	"./scripts/compile-dotnet-assemblies.bat",
	"./scripts/set-winrm-automatic.bat",
	"./scripts/uac-enable.bat",
	"./scripts/dis-updates.bat",
	"./scripts/compact.bat"
],
"type": "windows-shell"
```
	
#### Into this
```
"execute_command": "{{ .Vars }} cmd /c \"{{ .Path }}\"",
"remote_path": "/tmp/script.bat",
"scripts": [
	"./scripts/set-winrm-automatic.bat",
	"./scripts/uac-enable.bat",
	"./scripts/dis-updates.bat",
	"./scripts/compact.bat"
],
"type": "windows-shell"

```

### Removed
#### This
```
{
"scripts": [
  "./scripts/set-powerplan.ps1",
  "./scripts/docker/disable-windows-defender.ps1"
],
"type": "powershell"
},
```
#### This
```
{
"execute_command": "{{ .Vars }} cmd /c \"{{ .Path }}\"",
"remote_path": "/tmp/script.bat",
"scripts": [
  "./scripts/vm-guest-tools.bat",
  "./scripts/enable-rdp.bat"
],
"type": "windows-shell"
},
```
#### This
```
{
"scripts": [
  "./scripts/debloat-windows.ps1"
],
"type": "powershell"
},
```

## Builders
- Removed "floppy_file"
  - disable-winrm.ps1
  - win-updates.ps1
  - microsoft-updates.bat