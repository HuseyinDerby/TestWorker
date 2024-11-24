# Define variables
$serviceName = "MyBackgroundService"
$displayName = "My Background Service"
$description = "This is a background service running my .NET application."
$exePath = "C:\Users\137581\Documents\TestWorkflow\infrastructure\terraform\publish\staging\JokeService.exe" # Change this to the actual path of your .exe

# Check if the service already exists
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    Write-Host "Service '$serviceName' already exists. Stopping and removing existing service."
    Stop-Service -Name $serviceName -Force
    sc.exe delete $serviceName
}

# Register the service
New-Service -Name $serviceName -BinaryPathName "`"$exePath`"" `
            -DisplayName $displayName -Description $description -StartupType Automatic

# Start the service
Start-Service -Name $serviceName

# Verify the service status
$service = Get-Service -Name $serviceName
if ($service.Status -eq 'Running') {
    Write-Host "Service '$serviceName' is registered and running."
} else {
    Write-Host "Service '$serviceName' is registered but not running."
}
