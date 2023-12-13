# Script for Folder Scanning

## Overview

This script is designed to scan a folder and generate a report in the form of a CSV file.

## Usage

1. Initial Run:
   Upon the first execution of the script, a new folder named `scanned_folder` will be created in the script's
   directory. An initial version of `scan_output.csv` will also be generated, reflecting an empty scanned folder.

2. Subsequent Runs:
   Add the items you want to scan into the `scanned_folder`. Execute the script again to update the `scan_output.csv`
   report.

## Report Structure

The report contains the following three columns:

1. FullPath:
   Represents the full path of the scanned item.

2. FileName:
   Specifies the name of the file. If the full path is a folder, this field will be empty.

3. IsFile:
   Indicates whether the full path corresponds to a file (`True`) or a folder (`False`). Useful for filtering and
   distinguishing between folders and files.