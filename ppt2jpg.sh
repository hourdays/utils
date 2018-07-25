#!/bin/bash

## author: @hourdays
## usage: drop this file in a folder alongside PowerPoint presentations with a pptx extension
## prerequisites as validated on macOS High Sierra (10.13.4):
##     install LibreOffice between versions 3.6.0.1 - 4.3.x
##         https://downloadarchive.documentfoundation.org/libreoffice/old/
##     install unoconv
##         brew install unoconv
##     install ghostscript
##         brew install ghostscript
##     install imagemagick
##         brew install imagemagick

for file in *.pptx; do
    
    tempfile="${file##*/}"
    filename="${tempfile%.*}"

    ## convert to PDF
    unoconv --export Quality=100 "$filename".pptx "$filename".pdf

    ## create directory if it does not exist
    mkdir -p -- "$filename"
    
    ## convert to JPEG
    ## PowerPoint slides have a 1280 x 720 pixel resolution
    convert -scene 1 -density 400 "$filename".pdf -resize 1280x720 "$filename"/slide-%d.jpg

    ## delete PDF
    rm "$filename".pdf

done
