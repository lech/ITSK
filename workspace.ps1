# CSV one-liner to copy the files from the sourcePath column as named files defined in the destinationPath column.
# Note: the destination should already exist or will need to be created manually.
# Warning: If run multiple times, this WILL over-write your existing files. Tread carefully.
#
#sourcePath,destinationPath
#.\oldfile.ext,.\newfile1.ext
#.\oldfile.ext,.\newfile2.ext
#.\otherfile.ext,.\otherfile1.ext

Import-Csv .\workspace.csv | % { Copy-Item -Path $_.sourcePath -Destination "$($_.destinationPath)" }
