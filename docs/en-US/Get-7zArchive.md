---
external help file: 7zipWrapper-help.xml
Module Name: 7zipWrapper
online version: https://documentation.help/7-Zip/list.htm
schema: 2.0.0
---

# Get-7zArchive

## SYNOPSIS
List files fom a 7-Zip archive

## SYNTAX

```
Get-7zArchive [-ArchivePath] <String> [-Password <SecureString>] [-Switches <String>] [<CommonParameters>]
```

## DESCRIPTION
Use this cmdlet to examine the contents of 7-Zip archives.
Output is a list of PSCustomObjects with properties \[string\]Mode, \[DateTime\]DateTime, \[int\]Length, \[int\]Compressed and \[string\]Name
options to add to this would be -slt to show technical info

## EXAMPLES

### EXAMPLE 1
```
Get-7zArchive c:\temp\test.7z
```

List the contents of the archive "c:\temp\test.7z"

## PARAMETERS

### -ArchivePath
The name of the archive to list

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
If specified apply password to open archive

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Switches
Additional switches

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject[]
## NOTES
This function has not been updated yet.

## RELATED LINKS

[https://documentation.help/7-Zip/list.htm](https://documentation.help/7-Zip/list.htm)

