---
external help file: 7zipWrapper-help.xml
Module Name: 7zipWrapper
online version: https://documentation.help/7-Zip/list.htm
schema: 2.0.0
---

# New-7zArchive

## SYNOPSIS
Create a new 7-Zip archive

## SYNTAX

```
New-7zArchive [-ArchivePath] <String> [-FilesToInclude] <String[]> [-FilesToExclude <String[]>]
 [-ArchiveType <String>] [-Password <SecureString>] [-Switches <String>] [-Recurse] [-Force] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Use this cmdlet to create 7-Zip archives.
Possible types are 7z (default) as well as
zip, gzip, bzip2, tar, iso, udf archive formats. 
This needs testing...made usable
The archive file is overwritten if it exists and the -force parameter is used

## EXAMPLES

### EXAMPLE 1
```
New-7zArchive new-archive *.txt
```

Creates a new 7-zip-archive named 'new-archive.7z' containing all files with a .txt extension
in the current directory

### EXAMPLE 2
```
New-7zArchive new-archive *.txt -ArchiveType zip
```

Creates a new zip-archive named 'new-archive.zip' containing all files with a .txt extension
in the current directory

### EXAMPLE 3
```
New-7zArchive new-archive *.jpg,*.gif,*.png,*.bmp -Recurse -Exclude tmp/
```

Creates a new 7-zip archive named 'new-archive.7z' containing all files with an extension
of jpg, gif, png or bmp in the current directory and all directories below it

All files in the folder tmp are excluded, i.e.
not included in the archive.

## PARAMETERS

### -ArchivePath
The path of the archive to create

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

### -FilesToInclude
A list of file names or patterns to include

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilesToExclude
A list of file names or patterns to exclude

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ArchiveType
The type of archive to create

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 7z
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
If specified apply password to archive and encrypt headers

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
Additional switches for 7zip (Feature intended for advanced usage)

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

### -Recurse
Apply include patterns recursively

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
{{ Fill Force Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

## NOTES

## RELATED LINKS
