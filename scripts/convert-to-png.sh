#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"
#echo "$wd"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -iname "*.webp" -o -iname "*.jpg" -o -iname "*.jpeg") )
#echo "$files"

mkdir "$wd"/converted-to-png

i=$(echo "${#files[@]}" | bc)
for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	convert "${files[x]}" "$wd"/converted-to-png/"${files[x]}".png
done
