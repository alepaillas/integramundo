#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"
#echo "$wd"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -iname "*.webp" -o -iname "*.png" -o -iname "*.jpg") )
#echo "$files"

mkdir "$wd"/converted-to-jpg

i=$(echo "${#files[@]}" | bc)
for ((x=0; x < i; x++)); do
    echo "Processing ${files[x]}"
    convert "${files[x]}" "$wd"/converted-to-jpg/"${files[x]}".jpg
	#convert "${files[x]}" -sampling-factor 4:2:0 -define jpeg:dct-method=float -strip -interlace Plane -colorspace sRGB -quality 80% "$wd"/converted-to-jpg/"${files[x]}".jpg
done
