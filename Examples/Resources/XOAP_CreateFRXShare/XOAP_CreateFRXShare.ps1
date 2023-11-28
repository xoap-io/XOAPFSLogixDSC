Configuration 'XOAPFSLogixDSC'
{
	Import-DscResource -ModuleName 'XOAPFSLogixDSC' -Name 'XOAP_CreateFRXShare' -ModuleVersion '1.0.0'

    param
        (
            [String]$ShareName = 'FSLogix'
            [String]$ShareFullPath = 'C:\FSLogix'
            [String]$ModifyPermissionAccountOnSMBShare = 'ExampleGroup@domain.com'
            [String]$Domain = 'domain.com'
        )

	Node 'XOAPFSLogixDSC'
	{
        XOAP_CreateFRXShare 'Example'
            {
                ShareName                           =   $ShareName
                ShareFullPath                       =   $ShareFullPath
                ModifyPermissionAccountOnSMBShare   =   $ModifyPermissionAccountOnSMBShare
                ProfileDiskLocation                 =   $ProfileDiskLocation
                Domain                              =   $Domain
            }
	    }
}

XOAPFSLogixDSC -OutputPath 'C:\XOAPFSLogixDSC'
