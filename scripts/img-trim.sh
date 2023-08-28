#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" ! -iname "bg.png" ! -iname "logo.png" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg") )
#echo "$files"

mkdir "$wd"/trimmed-img

i=$(echo "${#files[@]}" | bc)

for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	#convert "${files[x]}" -fuzz 6% -trim +repage "${files[x]}-trim.png"
	convert "${files[x]}" -fuzz 6% -trim +repage "$wd"/trimmed-img/"${files[x]}"
done
