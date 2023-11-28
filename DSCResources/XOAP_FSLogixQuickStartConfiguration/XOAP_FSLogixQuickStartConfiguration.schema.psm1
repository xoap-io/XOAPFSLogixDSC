configuration XOAP_FSLogixQuickStartConfiguration
{
    param(    
    [Parameter(Mandatory = $true)]
    [System.String]$RemoteDesktopUsersMember,
    [Parameter(Mandatory = $true)]
    [System.String]$Domain,
    [Parameter(Mandatory = $false)]
    [System.String]$RedirXMLSourceFolder,
    [Parameter(Mandatory = $true)]
    [System.String]$ProfileDiskLocation
    )   
    
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration' -ModuleVersion '1.1'
    
    Script 'AddUserToGroup'
    {
        GetScript = {
        }
        SetScript = {
            Add-LocalGroupMember -Group "Remote Desktop Users" -Member $using:RemoteDesktopUsersMember
        }
        TestScript = {
            if(!(Get-LocalGroupMember -Group "Remote Desktop Users" -Member $using:RemoteDesktopUsersMember  -erroraction ignore))
            {
                return $false
            }
            else {return $true}
        }
    }

    Script 'AddAdministrator'
    {
        GetScript = {
        }
        
        SetScript = {
            $user ="Administrator@" + $using:Domain
            Add-LocalGroupMember -Group "FSLogix Profile Exclude List" -Member $user -erroraction ignore
        }
        
        TestScript = {
            $user = $using:domain + "\Administrator"
            if(!(Get-LocalGroupMember -Group "FSLogix Profile Exclude List" -Member $user -erroraction ignore))
            {
                return $false
            }
            else {return $true}
        }
    }

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
        ValueData = 1
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles'
        ValueType = 'Dword'
        ValueName = 'IsDynamic'
        Ensure = 'Present'
    }

    Registry  'HKLM:\SOFTWARE\FSLogix\Profiles\SizeInMBs'
    {
        ValueData = 30000
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
        ValueData = 'VHDX'
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles'
        ValueType = 'String'
        ValueName = 'VolumeType'
        Ensure = 'Present'
    }
}
