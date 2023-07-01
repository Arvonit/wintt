#!/usr/bin/env powershell

if ($args.Count -eq 0) {
    Write-Host "Usage: tt <file>"
    Exit 1
}

$args | ForEach-Object {
    $arg = $_;
    if ($arg -like '-*') {
        Write-Host "Usage: tt <file>"
        Exit 1
    }

    $fullPath = [System.IO.Path]::GetFullPath($arg)
    if (Test-Path -Path $fullPath) {
        try {
            # Recycle the file
            $shell = new-object -comobject "Shell.Application"
            $item = $shell.Namespace(0).ParseName($fullPath)
            $item.InvokeVerb("delete")
        }
        catch {
            Write-Host "tt: $_"
        }
    }
    else {
        Write-Host "tt: ${arg}: No such file or directory"
    }
}
