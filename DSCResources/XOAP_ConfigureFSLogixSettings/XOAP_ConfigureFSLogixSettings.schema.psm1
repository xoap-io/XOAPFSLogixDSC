configuration XOAP_ConfigureFSLogixSettings
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('0','1')]
        [System.String]$dynamicVHDx,
        [Parameter(Mandatory = $true)]
        [System.Int32]$SizeInMBs,
        [Parameter(Mandatory = $false)]
        [System.String]$RedirXMLSourceFolder,
        [Parameter(Mandatory = $true)]
        [System.String]$ProfileDiskLocation,
        [Parameter(Mandatory = $true)]
        [ValidateSet('VHD','VHDX')]
        [System.String]$VolumeType        
    )
    
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration' -ModuleVersion '1.1'

    
    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\DeleteLocalProfileWhenVHDShouldApply'
    {
        ValueData = 1
        Key = 'HKLM:\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'DeleteLocalProfileWhenVHDShouldApply'
        Ensure = 'Present'
   }

   Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\Enabled'
   {
        ValueData = 1
        Key = 'HKLM:\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'Enabled'
        Ensure = 'Present'
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\FlipFlopProfileDirectoryName'
    {
        ValueData = 1
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'FlipFlopProfileDirectoryName'
        Ensure = 'Present'
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\IsDynamic'
    {
        ValueData = $dynamicVHDx
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'IsDynamic'
        Ensure = 'Present'
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\SizeInMBs'
    {
        ValueData = $SizeInMBs
        Key = 'HKLM:\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'SizeInMBs'
        Ensure = 'Present'
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\LockedRetryCount'
    {
        ValueData = 3
        Key = 'HKLM:\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'LockedRetryCount'
        Ensure = 'Present'
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\LockedRetryInterval'
    {
        ValueData = 15
        Key = 'HKLM:\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'LockedRetryInterval'
        Ensure = 'Present'       
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\ReAttachIntervalSeconds'
    {
        ValueData = 15
        Key = 'HKLM:\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'ReAttachIntervalSeconds'
        Ensure = 'Present' 
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\ReAttachRetryCount'
    {
        ValueData = 3
        Key = 'HKLM:\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'ReAttachRetryCount'
        Ensure = 'Present'
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\RedirXMLSourceFolder'
    {
        ValueData = $RedirXMLSourceFolder
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles'
        ValueType = 'String'
        ValueName = 'RedirXMLSourceFolder'
        Ensure = 'Present'
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\VHDLocations'
    {
        ValueData = $ProfileDiskLocation
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles'
        ValueType = 'String'
        ValueName = 'VHDLocations'
        Ensure = 'Present'        
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\VolumeType'
    {
        ValueData = $VolumeType
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles'
        ValueType = 'String'
        ValueName = 'VolumeType'
        Ensure = 'Present'
    } 



}

