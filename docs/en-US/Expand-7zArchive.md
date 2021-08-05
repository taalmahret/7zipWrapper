---
external help file: 7zipWrapper-help.xml
Module Name: 7zipWrapper
online version: https://documentation.help/7-Zip/extract1.htm
schema: 2.0.0
---

# Expand-7zArchive

## SYNOPSIS
Extract files fom a 7-Zip archive

## SYNTAX

```
Expand-7zArchive [-ArchivePath] <String> [[-Destination] <String>] [[-Include] <String[]>]
 [-Exclude <String[]>] [-Password <SecureString>] [-Recurse] [-Switches <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
Use this cmdlet to extract files from an existing 7-Zip archive
Extracts files from an archive to the current directory or to the output
directory.
The output directory can be specified by -o switch.
This command copies all extracted files to one directory.
If you want
extracted files with full paths, you must use x command. 
7-Zip will
prompt the user before overwriting existing files unless the user
specifies the -y switch.
If the user gives a no answer, 7-Zip will
prompt for the file to be extracted to a new filename.
Then a no answer
skips that file; or, yes prompts for new filename.

## EXAMPLES

### EXAMPLE 1
```
Expand-7zArchive backups.7z
```

### EXAMPLE 2
```
Expand-7zArchive -Path archive.zip -Destination "c:\soft" -Include "*.cpp" -recurse
extracts all *.cpp files from archive archive.zip to c:\soft folder.
```

## PARAMETERS

### -ArchivePath
The path of the archive to expand

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

### -Destination
The path to extract files to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
A list of file names or patterns to include

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: @("*")
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Exclude
A list of file names or patterns to exclude

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
If specified apply password to archive and decrypt contents

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

### -Switches
Additional switches for 7zip

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

### -Force
Force overwriting existing files

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
This function has not been updated yet.

## RELATED LINKS

[https://documentation.help/7-Zip/extract1.htm](https://documentation.help/7-Zip/extract1.htm)

