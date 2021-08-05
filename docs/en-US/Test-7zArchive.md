---
external help file: 7zipWrapper-help.xml
Module Name: 7zipWrapper
online version: https://documentation.help/7-Zip/list.htm
schema: 2.0.0
---

# Test-7zArchive

## SYNOPSIS
Test files a 7-Zip archive.

## SYNTAX

```
Test-7zArchive [-ArchivePath] <String> [-Password <SecureString>] [[-Switches] <String>] [<CommonParameters>]
```

## DESCRIPTION
Use this cmdlet to test 7-Zip archives for errors

## EXAMPLES

### EXAMPLE 1
```
Test-7zArchive c:\temp\test.7z
```

Test the archive "c:\temp\test.7z".
Throw an error if any errors are found

## PARAMETERS

### -ArchivePath
The name of the archive to test

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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This function has not been updated yet.

## RELATED LINKS

[https://documentation.help/7-Zip/list.htm](https://documentation.help/7-Zip/list.htm)

