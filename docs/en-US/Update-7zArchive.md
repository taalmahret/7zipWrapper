---
external help file: 7zipWrapper-help.xml
Module Name: 7zipWrapper
online version: https://documentation.help/7-Zip/update.htm
schema: 2.0.0
---

# Update-7zArchive

## SYNOPSIS
Update files in a 7-Zip archive

## SYNTAX

```
Update-7zArchive [-ArchivePath] <String> [-FilesToInclude] <String[]> [-FilesToExclude <String[]>]
 [-ArchiveType <String>] [-Password <SecureString>] [-Switches <String>] [-Recurse] [-Force]
 [<CommonParameters>]
```

## DESCRIPTION
Use this cmdlet to update files to an existing 7-Zip archive.
If the archive does not
exist, it is created.
Update-7zArchive will update older files in the archive and add
files that are new to the archive. 
This does not replace unchanged files within the
archive, instead those files are skipped.
This is for speed improvements.

## EXAMPLES

### EXAMPLE 1
```
Update-7zArchive existing-archive *.txt
```

Updates an existing 7-zip-archive named 'existing-archive.7z' with all files found
having a .txt extension in the current directory that are newer than the files in the
archive and all files that are not currently in the archive.

### EXAMPLE 2
```
Update-7zArchive existing-archive *.txt -ArchiveType zip
```

Updates an existing zip-archive named 'existing-archive.zip' with all files found
having a .txt extension in the current directory that are newer than the files in the
archive and all files that are not currently in the archive.

### EXAMPLE 3
```
Update-7zArchive existing-archive *.jpg,*.gif,*.png,*.bmp -Recurse -Exclude tmp/
```

Updates an existing 7-zip-archive named 'existing-archive.7z' with all files found
having a jpg, gif, png or bmp extension in the current directory and all sub
directories that are newer than the files in the archive and all files that are not
currently in the archive.

All files in the folder tmp are excluded, i.e.
not included in the archive.

## PARAMETERS

### -ArchivePath
The path of the archive to update

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
Accept pipeline input: True (ByValue)
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
The type of archive to update

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
If specified apply password to open and update this archive

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
The current version of 7-Zip cannot change an archive which was created with the solid
option switched on.
To update a .7z archive you must create and update that archive
only in non-solid mode (-ms=off switch).

## RELATED LINKS

[https://documentation.help/7-Zip/update.htm](https://documentation.help/7-Zip/update.htm)

