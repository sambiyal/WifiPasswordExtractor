# Display a banner
Write-Host "-------------------------------------"
Write-Host "-------------------------------------"
Write-Host "RedArsenal Wireless Profile Information"
Write-Host "-------------------------------------"
Write-Host "-------------------------------------"
# Get a list of all saved WiFi profiles
$profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { $_ -replace "    All User Profile\s+:\s+", "" }

# Loop through each WiFi profile and retrieve the password
foreach ($profile in $profiles) {
    $profileInfo = netsh wlan show profile name="$profile" key=clear
    $passwordLine = $profileInfo | Select-String "Key Content"
    
    if ($passwordLine) {
        $password = ($passwordLine -split ":\s+")[1]
        Write-Host "WiFi Profile: $profile"
        Write-Host "Password: $password"
        Write-Host "--------------------------"
    }
}
