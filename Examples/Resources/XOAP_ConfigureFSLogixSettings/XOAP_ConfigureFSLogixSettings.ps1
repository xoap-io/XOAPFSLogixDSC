Configuration 'XOAPFSLogixDSC'
{
	Import-DscResource -ModuleName 'XOAPFSLogixDSC' -Name 'XOAP_ConfigureFSLogixSettings' -ModuleVersion '1.0.0'

    param
        (
            [String]$dynamicVHDx = '1'  # '1','2'
            [Int32]$SizeInMBs = 30000
            [String]$RedirXMLSourceFolder = '\\ExampleShare\RedirXMLSourceFolder'
            [String]$ProfileDiskLocation = '\\ExampleShare\ProfileDiskLocation'
            [String]$VolumeType = 'VHDX' #'VHD', 'VHDX'
        )

	Node 'XOAPFSLogixDSC'
	{
        XOAP_ConfigureFSLogixSettings 'Example'
            {
                dynamicVHDx             =   $dynamicVHDx
                SizeInMBs               =   $SizeInMBs
                RedirXMLSourceFolder    =   $RedirXMLSourceFolder
                ProfileDiskLocation     =   $ProfileDiskLocation
                VolumeType              =   $VolumeType
            }
	    }
}

XOAPFSLogixDSC -OutputPath 'C:\XOAPFSLogixDSC'
