param(
[string]$PC
#$PC = Read-Host 'PC to get the serialnumber of?' 
)

Write-Host "Getting serialnumber of $PC"

$counter = 0


while ($counter -ne 1){

$Test = Test-Connection -computername $PC -erroraction silentlycontinue -count 1 -delay 60 -ttl 225
$serial = (Get-WMIObject Win32_BIOS -computer $PC -ErrorAction SilentlyContinue).SerialNumber

if ($serial -ne $null){
$serial = (Get-WMIObject Win32_BIOS -computer $PC -ErrorAction SilentlyContinue).SerialNumber
$counter = $counter + 1
}

}

send-mailmessage -smtpserver 10.32.158.37 -to "bvitko@Mednet.ucla.edu" -from "Powershell <powershell@mednet.ucla.edu>" -Subject "Serial Number Found!" -body "Serial Number of $PC is $serial!"

Add-Content c:\drivers\serialnumber-results.txt "$PC has a serial number of $serial."
