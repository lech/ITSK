# Inkscape Theme Starter Kit

This is a simple and dirty method to quickly unpack a SVG workspace using a few core SVG files. Rather than needing to setup your document properties, licensing, metadata, grids, colors and other settings for icons individually each and every time. Prepare your SVG files and CSV document once and copy out the files you need created from fewer, controlled sources instead.

---

## What's included?

Inkscape is a powerful vector drawing application, however the number of application icons are numerous. Previously this was managed through a single file as an icon sheet, now there are several hundred files needed to build up a complete theme. The goal of this is to help make the initial task of starting up much easier.

This method was developed to help quickly prepare and copy all of the necessary files on Windows leveraging a little bit of PowerShell to do so. It should be easy enough to understand and pick apart to translate for Bash or any other shell scripting language on Mac or Linux. If something like this already exists, drop me a message and let me know.

For more, see [Creating a multicolor icon](https://wiki.inkscape.org/wiki/Creating_a_multicolor_icon) on the  [Inkscape Wiki](https://wiki.inkscape.org/wiki/Inkscape) for a more in-depth and practical guides on creating icons and themes.

### How to use:

> **Notes and warnings**: All operations are performed within the local `".\"` working directory.
  - ALWAYS make backups of your work!
  - Running this multiple times can and will result in overwriting existing files rolling you back to a blank state.
  - If the output folder needed to copy into does not exist, it will need to be created.
  - Odds are you will only need to use this once, after your files are created it's wise to move/remove these files or your working directory after.
  - This does not create the index.theme, gtkrc or any other files for you. Those will still need to be created and defined manually.

  1. Extract this project to its own directory.
  2. Edit the CSV and your SVG source files, set them up and make them your own.
  3. Create a new `actions` directory, this is where all files will be created.
  4. From PowerShell, run `.\workspace.ps1` or copy and paste the one-liner used below.
  5. Within the `actions` directory, review the files created.
  6. Draw your own icons and open the `_index.html` to preview your work in a browser.

---

## The Files

This sections outlines all the included and necessary files.

### The icons.html

This is a simple, flexible and static HTML file built up from references collected from the CSV. It's a handy reference for *most icon files* found within the theme you will be creating. Use this to quickly review your SVG files in one place.

All icons are scaled to `64x64` pixels for easy viewing. If included on copy, it will be copied as `_icons.html` and should stand out near one end of your directory view.

### SVG source files

Included are two core SVG files: `blank256grid.svg` and `blank384grid.svg`. Edit these and make them your own before deploying or include your own from the start and rewrite the CSV. Setup your document properties: author info, licensing, and everything here first.

If you've examined the included CSV file, you will see that I switch between `blank256grid.svg` and `blank384grid.svg` which are `256x256` and `384x384` blank sources with a grid and all metadata attached. As Inkscape scales icons in multiples of 6 and 8 (16/24/32/48/64/96) pixels throughout the UI, this helps maintain some level of alignment and consistency allowing for thicker lines.

Scaling these files up in size also provides some ease of editing at a reasonable default size. And offers some finer control for pixel-perfect sharpness after they're brought back in and resized within the Inkscape UI.

### The workspace.csv

The included `workspace.csv` contains all the pick and place information necessary for copying and naming the files for you. Its format should look something like the following:

```CSV
sourcePath,destinationPath
.\icons.html,.\actions\_icons.html
.\blank384grid.svg,.\actions\align-horizontal-baseline-symbolic.svg
.\blank384grid.svg,.\actions\align-horizontal-center-symbolic.svg

...

.\blank256grid.svg,.\actions\zoom-previous-symbolic.svg
.\blank256grid.svg,.\actions\zoom-symbolic.svg
```

### The workspace.ps1

All of the heavy lifting is done in one line of `workspace.ps1` which will require a `workspace.csv` to reference. This file isn't really needed if you're comfortable pasting this in by hand:

```PowerShell
Import-Csv .\workspace.csv | % { Copy-Item -Path $_.sourcePath -Destination "$($_.destinationPath)" }
```

This should hopefully be self-explanatory. In case it's not: this uses PowerShells `Import-Csv` function to read the contents of a `workspace.csv` file and copy the item from the `sourcePath` column and copy them out with the filenames in the `destinationPath` column. Basic.

---

# DIY CSV

An Inkscape icon file list can be built up from some of the default locations on Windows:

```CSV
%ProgramFiles%\Inkscape\share\inkscape\icons\
%ProgramFiles%\Inkscape\share\inkscape\icons\hicolor\
%ProgramFiles%\Inkscape\share\inkscape\icons\multicolor\
%ProgramFiles%\Inkscape\share\inkscape\icons\Tango\
...
```

The following example will produce a `workspaceNew.csv` file which you will need to edit after it is created. This example references the default Windows install path for Inkscape using the multicolor set to build the file list:

```PowerShell
Get-ChildItem "C:\Program Files\Inkscape\share\inkscape\icons\multicolor\symbolic\actions" | Select-Object Exists,Name | ConvertTo-Csv -Delimiter "," | % {$_ -Replace '"',''} | % {$_ -Replace ',',',.\actions\'} | % {$_ -Replace 'True,','.\sourceIcon.svg,'} > workspaceNew.csv
```

It's a bit dirty, but it does the job and you should be able to open this in any editor after it is created.

The output should produce two columns of data to work with and removes any extraneous quotations. It's also appending the path to copy files into the `.\actions\` directory for use later. Afterward you will just need to update the column references from: `Exists,.\actions\Name` to `sourcePath,destinationPath`.

You may also want to add `.\icons.html,.\actions\_icons.html` which will include a copy of the necessary HTML file if you want a quick way to see all icons in the browser as you work on them.

---

## License

MIT License

Copyright (c) 2022 Lech Deregowski

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
