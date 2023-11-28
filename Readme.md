# XOAPFSLogixDSC

This repository contains a PowerShell DSC module for the deployment of a complete FSLogix environment.

## Code of Conduct

This project has adopted this [Code of Conduct](CODE_OF_CONDUCT.md).

## Contributing

Please check out common DSC Community [contributing guidelines](https://dsccommunity.org/guidelines/contributing).

## Change log

A full list of changes in each version can be found in the [Releases](https://github.com/xoap-io/XOAPFSLogixDSC/releases).

## Prerequisites

Be sure that the following DSC modules are installed on your system:

- ComputerManagementDsc (9.0.0)
- cNtfsAccessControl (1.4.1)

## Documentation

The XOAP FSLogix DSC module contains the following resources:

### XOAP_AddToRemoteDesktopUsersGroup

```PowerShell
XOAP_AddToRemoteDesktopUsersGroup [String] #ResourceName
    {
        [DependsOn = [String[]]]
        [PsDscRunAsCredential = [PSCredential]]
        [RemoteDesktopUsersMember = [String]]
        [Domain = [String]]
    }
```

### XOAP_ConfigureFSLogixSettings

```PowerShell
XOAP_ConfigureFSLogixSettings [String] #ResourceName
    {
        [DependsOn = [String[]]]
        [PsDscRunAsCredential = [PSCredential]]
        [dynamicVHDx = [String]] #'0','1'
        [SizeInMBs = [Int32]]
        [RedirXMLSourceFolder = [String]]
        [ProfileDiskLocation = [String]]
        [VolumeType = [String]] #'VHD','VHDX'
    }
```

### XOAP_CreateFRXShare

```PowerShell
XOAP_CreateFRXShare [String] #ResourceName
    {
        [DependsOn = [String[]]]
        [PsDscRunAsCredential = [PSCredential]]
        [ShareName = [String]]
        [ShareFullPath = [String]]
        [ModifyPermissionAccountOnSMBShare = [String]]
        [Domain = [String]]
    }
```

### XOAP_FSLogixQuickStartConfiguration

```PowerShell
XOAP_FSLogixQuickStartConfiguration [String] #ResourceName
    {
        [DependsOn = [String[]]]
        [PsDscRunAsCredential = [PSCredential]]
        [RemoteDesktopUsersMember = [String]]
        [Domain = [String]]
        [RedirXMLSourceFolder = [String]]
        [ProfileDiskLocation = [String]]
    }
```

## Configuration examples for each resource

To implement the FSLogix DSC module, add the following resources to your DSC configuration and adjust the parameters accordingly:

### Add users to "Remote Desktop Users" group

```PowerShell
Configuration 'XOAP_AddToRemoteDesktopUsersGroup'
{
    Import-DscResource -ModuleName 'XOAPFSLogixDSC' -Name 'XOAP_AddToRemoteDesktopUsersGroup' -ModuleVersion '1.0.0'
    
    XOAP_AddToRemoteDesktopUsersGroup 'Example'
    {
	    RemoteDesktopUsersMember [String]= 'Example@domain.com'
	    Domain [String]= 'Example'
    }
}
XOAP_AddToRemoteDesktopUsersGroup
```

### Configure FSLogix Settings

```PowerShell
Configuration 'XOAP_ConfigureFSLogixSettings'
{
    Import-DscResource -ModuleName 'XOAPFSLogixDSC' -Name 'XOAP_ConfigureFSLogixSettings' -ModuleVersion '1.0.0'
    
    XOAP_ConfigureFSLogixSettings 'Example'
    {
	    dynamicVHDx [String]= '1'
	    SizeInMBs [Int32]= '30000'
            RedirXMLSourceFolder [String]= '\\ExampleShare\RedirXMLSourceFolder'
            ProfileDiskLocation [String]= '\\ExampleShare\ProfileDiskLocation'
            VolumeType [String]= 'VHDX'
    }
}
XOAP_ConfigureFSLogixSettings
```

### Create and configure FRX Share

```PowerShell
Configuration 'XOAP_CreateFRXShare'
{
    Import-DscResource -ModuleName 'XOAPFSLogixDSC' -Name 'XOAP_CreateFRXShare' -ModuleVersion '1.0.0'
    
    XOAP_ConfigureFSLogixSettings 'Example'
    {
	    ShareName [String]= 'Example'
	    ShareFullPath [String]= 'C:\Example'
            ModifyPermissionAccountOnSMBShare [String]= 'example@domian.com'
            Domain [String]= 'domain.com'
    }
}
XOAP_CreateFRXShare
```

### Quick configuration

```PowerShell
Configuration 'XOAP_FSLogixQuickStartConfiguration'
{
    Import-DscResource -ModuleName 'XOAPFSLogixDSC' -Name 'XOAP_FSLogixQuickStartConfiguration' -ModuleVersion '1.0.0'
    
    XOAP_FSLogixQuickStartConfiguration 'Example'
    {
	    RemoteDesktopUsersMember [String]= 'ExampleGroup@domain.com'
	    Domain [String]= 'domain.com'
            RedirXMLSourceFolder [String]= '\\ExampleShare\RedirXMLSourceFolder'
            ProfileDiskLocation [String]= '\\ExampleShare\ProfileDiskLocation'
    }
}
XOAP_FSLogixQuickStartConfiguration
```
