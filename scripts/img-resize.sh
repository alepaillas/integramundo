#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" ! -iname "logo.png" ! -iname "bg.png" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg") )

#echo "$files"

mkdir "$wd"/resized-img

i=$(echo "${#files[@]}" | bc)

for ((x=0; x < i; x++)); do
	echo "Resizing ${files[x]}"
	#convert "${files[x]}" -resize 1500x1500 "${files[x]}-1500px.png"
	magick "${files[x]}" -resize "$1" "$wd"/resized-img/"${files[x]}"
done
