Configuration 'XOAPFSLogixDSC'
{
	Import-DscResource -ModuleName 'XOAPFSLogixDSC' -Name 'XOAP_FSLogixQuickStartConfiguration' -ModuleVersion '1.0.0'

    param
        (
            [String]$RemoteDesktopUsersMember = 'ExampleGroup@domain.com'
            [String]$Domain = 'domain.com'
            [String]$RedirXMLSourceFolder = '\\ExampleShare\RedirXMLSourceFolder'
            [String]$ProfileDiskLocation = '\\ExampleShare\ProfileDiskLocation'
        )

	Node 'XOAPFSLogixDSC'
	{
        XOAP_FSLogixQuickStartConfiguration 'Example'
            {
                RemoteDesktopUsersMember    =   $ShareName
                Domain                      =   $ShareFullPath
                RedirXMLSourceFolder        =   $ModifyPermissionAccountOnSMBShare
                ProfileDiskLocation         =   $ProfileDiskLocation
            }
	    }
}
XOAPFSLogixDSC -OutputPath 'C:\XOAPFSLogixDSC'
