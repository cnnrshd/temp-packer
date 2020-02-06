# Commando notes
Last time I ran this, it took ~4 hours to install everything in the Commando script. We might want to add a windows-restart (Or a script that checks to see if the installation has finished? Not sure how this can be done, since I don't think there's an order to how packages are installed) set for 4ish hours between these two:

```
		{
			"type": "powershell",
			"script": "{{user `scripts_folder`}}install-commando.ps1",
			"environment_vars": [
				"PASSWORD=P@ssw0rd-123!",
				"NO_CHECKS=true"
			]
		},
		{
			ADD IT HERE
		},
		{
			"type": "powershell",
			"script": "{{user `scripts_folder`}}install-cloudbase.ps1"
		},
```