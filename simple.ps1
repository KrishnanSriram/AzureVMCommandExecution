# $stdErrLog = "C:\stderr.log"
$stdOutLog = "C:\stdout.log"
$output = Get-LocalUser
# Start-Process -File myjob.bat -RedirectStandardOutput $stdOutLog -RedirectStandardError $stdErrLog -wait
Get-ComputerInfo > $stdOutLog
Write-Output $output
$output