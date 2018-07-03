
If (![bool]([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{Throw "Launch with administrator rights"}
Invoke-WebRequest -Uri 'http://download.eset.com/download/sysinspector/64/ENU/SysInspector.exe' -outfile "$env:public\SysInspector.exe"
cd $env:PUBLIC
$Filename = "$env:PUBLIC\SysInspector-$env:Computername-$(Get-date -format 'yyMMdd-hhmmss').zip"
Write-Host "SysInspector working, wait"
$ProcessHandle = Start-Process "$env:PUBLIC\sysinspector.exe" -ArgumentList "/gen=$Filename /silent /privacy /zip" -Passthru
Do {
    ++$ElapsedTime
    Start-Sleep -Seconds 60
    Write-Host "Work $ElapsedTime min"
} until ($ProcessHandle.HasExited -eq $True)
Write-Host "Please send a create file -  `"$Filename`""
