net stop tiledatamodelsvc
if exist a:\Autounattend.xml (
  c:\windows\system32\sysprep\sysprep.exe /generalize /unattend:a:\Autounattend.xml
) else (
  del /F \Windows\System32\Sysprep\unattend.xml
  c:\windows\system32\sysprep\sysprep.exe /generalize
)
