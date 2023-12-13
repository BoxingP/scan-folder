$scriptFolderPath = $PSScriptRoot

$scanFolderName = "scanned_folder"
$scanFolderPath = Join-Path -Path $scriptFolderPath -ChildPath $scanFolderName

function New-Folder
{
    param (
        [string]$folderPath
    )

    if (-not(Test-Path -Path $folderPath -PathType Container))
    {
        New-Item -ItemType Directory -Path $folderPath
        Write-Host "Folder created: $folderPath"
    }
    else
    {
        Write-Host "Folder already exists: $folderPath"
    }
}

New-Folder -folderPath $scanFolderPath

$outputCsvName = "scan_output.csv"
$outputCsvPath = Join-Path -Path $scriptFolderPath -ChildPath $outputCsvName

function Get-FilesAndFolders
{
    param (
        [string]$path,
        [string]$parentPath
    )

    $items = Get-ChildItem -Path $path

    foreach ($item in $items)
    {
        if ($item.PSIsContainer)
        {
            $folderPath = $item.FullName
            $outputFolder = [PSCustomObject]@{
                'FullPath' = $folderPath
                'FileName' = ""
                'IsFile' = "False"
            }
            $outputFolder | Export-Csv -Path $outputCsvPath -Append -NoTypeInformation

            Get-FilesAndFolders -path $folderPath -parentPath $folderPath
        }
        else
        {
            $filePath = $item.FullName
            $fileName = $item.Name
            $outputFile = [PSCustomObject]@{
                'FullPath' = $filePath
                'FileName' = $fileName
                'IsFile' = "True"
            }
            $outputFile | Export-Csv -Path $outputCsvPath -Append -NoTypeInformation
        }
    }
}

@('FullPath,FileName,IsFile') | Out-File -FilePath $outputCsvPath -Encoding utf8
Get-FilesAndFolders -path $scanFolderPath -parentPath ""

Write-Host "Scan completed. Results saved to: $outputCsvPath"
