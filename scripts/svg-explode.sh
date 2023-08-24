#!/bin/bash

# depends on
# - inkscape

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

# bash array
files=( $(find . -type f ! -name "$controlchars" -iname "*.svg" -o -iname "*.SVG") )
#echo "$files"

i=$(echo "${#files[@]}" | bc)
#echo "$i"

for ((x=0; x < i; x++)); do
    echo "Processing ${files[x]}"
    
    #images=( $(inkscape --query-all ${files[x]} | grep image | sed -e 's/,.*//') )

    # gets you the second id called image
    # incredibly dumb and inefficient but who cares lol
    images=( $(inkscape --query-all ${files[x]} | grep image | head -n 2 | tail -n 1 | sed -e 's/,.*//') )
    #echo "$images"
    
    j=$(echo "${#images[@]}" | bc)
    #echo "$j"
    
    for ((y=0; y < j; y++)); do
	echo "Exporting id ${images[y]}"
	inkscape --export-type="png" --export-id="${images[y]}" --export-id-only ${files[x]} -o ${files[x]}-${images[y]}.png
    done
done
