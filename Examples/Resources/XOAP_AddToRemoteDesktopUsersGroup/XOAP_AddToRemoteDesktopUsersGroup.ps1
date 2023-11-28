Configuration 'XOAPFSLogixDSC'
{
	Import-DscResource -ModuleName 'XOAPFSLogixDSC' -Name 'XOAP_AddToRemoteDesktopUsersGroup' -ModuleVersion '1.0.0'

    param
        (
            [String]$RemoteDesktopUsersMember = 'ExampleGroup@domain.com'
            [String]$Domain = 'domain.com'

        )

	Node 'XOAPFSLogixDSC'
	{
        XOAP_AddToRemoteDesktopUsersGroup 'Example'
            {
                RemoteDesktopUsersMember    =   $RemoteDesktopUsersMember
                Domain                      =   $Domain

	    }
    }
}

XOAPFSLogixDSC -OutputPath 'C:\XOAPFSLogixDSC'
