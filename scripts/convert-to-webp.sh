#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"
#echo "$wd"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -iname "*.avif" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname ".png") )
#echo "$files"

mkdir "$wd"/converted-to-webp

i=$(echo "${#files[@]}" | bc)
for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	convert "${files[x]}" "$wd"/converted-to-webp/"${files[x]}".webp
done
