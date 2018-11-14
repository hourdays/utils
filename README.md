# utils

## ppt2jpg.sh
Is a shell script to convert Microsoft PowerPoint slides to JPEG images.
Tested on macOS High Sierra with the following prerequisites:
* [LibreOffice between versions 3.6.0.1 - 4.3.x](https://downloadarchive.documentfoundation.org/libreoffice/old/)
* install unoconv `brew install unoconv`
* install ghostscript `brew install ghostscript`
* install imagemagick `brew install imagemagick`

## mlvs.sh
Is a shell script to switch MarkLogic version with timestamping so as to switch between several identical MarkLogic versions.
It does not handle converters for now.
Not for production, this is simply used for demo purposes.
Tested on macOS High Sierra. Relies on awk, which is a package that may need to be installed on other unix ditributions.
