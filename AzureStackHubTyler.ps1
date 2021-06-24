#publish to gallery
.\AzureStackHubGallery.exe package -m C:\Users\Tyler.Du\Downloads\Packaging\RHEL8BYOL\manifest.json -o C:\Users\Tyler.Du\Downloads\Packaging

.\AzureStackHubGallery.exe package -m C:\Users\Tyler.Du\Downloads\Packaging\Win10BYOL\manifest.json -o C:\Users\Tyler.Du\Downloads\Packaging


#If cannot install with nuget error
[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12

#install az
Install-Module az

#install winrm
# https://docs.microsoft.com/en-us/azure-stack/operator/azure-stack-powershell-install?view=azs-2102

Install-module -Name PowerShellGet -Force
Import-Module -Name PackageManagement -ErrorAction Stop
Get-PSRepository -Name "PSGallery"

#import module
Import-Module az
Import-Module -Name azurerm

#connect
Connect-AzAccount #this is to global Azure
Connect-AzAccount -Environment AzureChinaCloud




#az has error, using AzureRM
$ArmEndpoint = "https://adminmanagement.beijing.azscloud.lenolab.com"
Add-AzureRMEnvironment -Name "AzureStackAdmin" -ArmEndpoint $ArmEndpoint
Add-AzureRMAccount -EnvironmentName "AzureStackAdmin"


Add-AzsGalleryItem -GalleryItemUri `
https://steutosimage001.blob.beijing.azscloud.lenolab.com/co-eut-image-win10/EUT.Windows10-BYOL.1.0.0.azpkg -Verbose

Add-AzsGalleryItem -GalleryItemUri `
https://steutosimage001.blob.beijing.azscloud.lenolab.com/co-fleet-image-rhel/EUT.RHEL8-BYOL-01.1.0.0.azpkg -Verbose

Get-AzureRmImage




Add-AzsPlatformimage -publisher "EUT" `
   -offer "Windows10-BYOL" `
   -sku "10" `
   -version "1.0.0" `
   -OSType "Windows" `
   -OSUri "https://steutosimage001.blob.beijing.azscloud.lenolab.com/co-eut-image-win10/win10image.vhd"

Get-AzureRmContext

Get-AzureRmLocation

Get-AzsGalleryItem | ft ItemDisplayName, name | findstr 10

Get-AzsGalleryItem | fl

Get-AzsPlatformImage

Remove-AzsGalleryItem -Name EUT.Windows10-BYOL.1.0.0 -Verbose