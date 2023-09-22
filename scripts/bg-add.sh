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

mkdir "$wd"/added-bg

i=$(echo "${#files[@]}" | bc)

for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	#convert -composite -gravity center bg.png "${files[x]}" "${files[x]}-bg.png"
	convert -composite -gravity center /mnt/c/Users/venta/ale/img-db/bg.png "${files[x]}" "$wd"/added-bg/"${files[x]}"
done
