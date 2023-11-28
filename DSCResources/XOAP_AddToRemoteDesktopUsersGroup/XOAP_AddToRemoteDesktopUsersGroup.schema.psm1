configuration 'XOAP_AddToRemoteDesktopUsersGroup'
{
    param(
        [Parameter(Mandatory = $true)]
        [System.String]$RemoteDesktopUsersMember,
        [Parameter(Mandatory = $true)]
        [System.String]$Domain
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
}
