#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

# bash array
files=( $(find . -type f ! -name "$controlchars" ! -iname "logo.png" ! -iname "bg.png" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg") )

#echo "$files"

i=$(echo "${#files[@]}" | bc)

for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	#convert "${files[x]}" -resize 1500x1500 "${files[x]}-1500px.png"
	convert "${files[x]}" -resize 1500x1500 "${files[x]}"
done
