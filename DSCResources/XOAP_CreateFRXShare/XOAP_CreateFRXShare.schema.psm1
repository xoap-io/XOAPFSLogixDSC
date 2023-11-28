configuration XOAP_CreateFRXShare
{
    param(
    [Parameter(Mandatory = $true)]
    [System.String]$ShareName,
    [Parameter(Mandatory = $true)]
    [System.String]$ShareFullPath,
    #Specifies which accounts will be granted modify permission to access the SMB share.
    [Parameter(Mandatory = $true)]
    [System.string[]]$ModifyPermissionAccountOnSMBShare,
    [Parameter(Mandatory = $true)]
    [System.String]$Domain
)

    Import-DSCResource -ModuleName 'ComputerManagementDsc' -ModuleVersion '9.0.0'
    Import-DSCResource -ModuleName 'cNtfsAccessControl' -ModuleVersion '1.4.1'

    SmbShare 'FRXshare' 
    {
        name = $ShareName
        path = $ShareFullPath
        ChangeAccess = $ModifyPermissionAccountOnSMBShare
    }
    
    cNtfsPermissionEntry 'DomainAdminsPermission'
    {
        Ensure = 'Present'
        Path = $ShareFullPath
        Principal = "Domain Admins@"+$domain
        AccessControlInformation = @(
            cNtfsAccessControlInformation
            {
                AccessControlType = 'Allow'
                FileSystemRights = 'FullControl'
                Inheritance = 'ThisFolderSubfoldersAndFiles'
                NoPropagateInherit = $false
            }
        )
    }

    # Ensure that multiple permission entries are assigned to the local 'Administrators' group.
    cNtfsPermissionEntry 'CreatorOwnerPermission'
    {
        Ensure = 'Present'
        Path = $ShareFullPath
        Principal = "CREATOR OWNER"
        AccessControlInformation = @(
            cNtfsAccessControlInformation
            {
                AccessControlType = 'Allow'
                FileSystemRights = 'Modify'
                Inheritance = 'SubfoldersAndFilesOnly'
                NoPropagateInherit = $false
            }
        )
     }

    # Ensure that multiple permission entries are assigned to the local 'Administrators' group.
    cNtfsPermissionEntry 'DomainUserPermission'
    {
        Ensure = 'Present'
        Path = $ShareFullPath
        Principal = "Domain Users@"+$domain
        AccessControlInformation = @(
            cNtfsAccessControlInformation
            {
                AccessControlType = 'Allow'
                FileSystemRights = 'Modify'
                Inheritance = 'ThisFolderOnly'
                NoPropagateInherit = $false
            }
        )
    }
}
