#!/bin/bash

# depends on
# - imagemagick
# - https://github.com/nadermx/backgroundremover

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

# bash array
#files=( $(find . -type f ! -name "$controlchars" ! -iname "bg.png" ! -iname "logo.png" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg") )

#echo "$files"

#i=$(echo "${#files[@]}" | bc)

#for ((x=0; x < i; x++)); do
#	echo "Processing ${files[x]}"
#	${BASH_SOURCE%/*}/bg-remove.sh
#	${BASH_SOURCE%/*}/img-trim.sh
#	${BASH_SOURCE%/*}/img-resize.sh
#	${BASH_SOURCE%/*}/bg-add.sh
#	${BASH_SOURCE%/*}/fg-add.sh
#done

echo "Working on $(pwd)"
${BASH_SOURCE%/*}/img-trim.sh
cd trimmed-img
echo "Moving into $(pwd)"
${BASH_SOURCE%/*}/img-resize.sh 1500x1500
cd resized-img
echo "Moving into $(pwd)"
${BASH_SOURCE%/*}/bg-add.sh
cd added-bg
echo "Moving into $(pwd)"
${BASH_SOURCE%/*}/fg-add.sh
