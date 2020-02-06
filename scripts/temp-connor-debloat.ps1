# - Windows update tasks aren't getting disabled. Need to look for a newer Debloat script - can try `disable-scheduledtask -Taskpath "\Microsoft\Windows\WindowsUpdate\"`
# - Onedrive setup is not getting deleted. Check `C:\Windows\SysWOW64\OneDriveSetup.exe` and remove it
write-host "disabling windows updates tasks"
get-scheduledtask | where-object {$_.taskpath -like "*update*"} | disable-scheduledtask

write-host "removing onedrive setup executable"
remove-item "C:\Windows\SysWOW64\OneDriveSetup.exe" -Force

exit 0