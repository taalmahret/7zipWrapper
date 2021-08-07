---
external help file: 7zipWrapper-help.xml
Module Name: 7zipWrapper
online version: https://documentation.help/7-Zip/sfx.htm
schema: 2.0.0
---

# New-7zSfx

## SYNOPSIS
Create a new 7-Zip self extracting archive

## SYNTAX

```
New-7zSfx [-Path] <String> [-Include] <String[]> [-CommandToRun] <String> [-Title <String>]
 [-BeginPrompt <String>] [-ExtractTitle <String>] [-ExtractDialogText <String>] [-ExtractCancelText <String>]
 [-ConfigOptions <String[]>] [-Recurse] [-Switches <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create self-extracting archives using 7-Zip

## EXAMPLES

### EXAMPLE 1
```
New-7zsfx app-sfx app.exe,app.exe.config app.exe
```

Simply create a self-extracting exe from an executable file app.exe
with its configuration file app.exe.config:

## PARAMETERS

### -Path
The name of the exe-file to produce, without extension

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

### -Include
The files to include in the archive

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

### -CommandToRun
The command to run when the sfx archive is started

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Title for messages

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

### -BeginPrompt
Begin Prompt message

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

### -ExtractTitle
Title of extraction dialog

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

### -ExtractDialogText
Text in dialog

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

### -ExtractCancelText
Button text of cancel button

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

### -ConfigOptions
A list of additional options, of the form "key=value"

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

### -Recurse
Include subdirectories

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
Additional switches to pass to 7za when creating the archive

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
This function has not been updated yet. 
This might be omitted in
later revisions as this sets off my sense of DSC flow and its old
in its concept. 
Since WinRM and DSC self expanding objects are a
non starter. 
I have excluded this from being exported for now.

Title - title for messages
BeginPrompt - Begin Prompt message
Progress - Value can be "yes" or "no".
Default value is "yes".
RunProgram - Command for executing.
Default value is "setup.exe".
Substring %%T will be replaced with path to temporary folder, where files were extracted
Directory - Directory prefix for "RunProgram".
Default value is ".\\\\"
ExecuteFile - Name of file for executing
ExecuteParameters - Parameters for "ExecuteFile"
ExtractTitle - title of extraction dialog
ExtractDialogText - text in dialog
ExtractCancelText - button text of cancel button

## RELATED LINKS

[https://documentation.help/7-Zip/sfx.htm](https://documentation.help/7-Zip/sfx.htm)

