#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"
#echo "$wd"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -iname "*.webp" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg") )
#echo "$files"

mkdir "$wd"/waifu2x

i=$(echo "${#files[@]}" | bc)
for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	waifu2x-converter-cpp -i ${files[x]} -o "$wd"/waifu2x/${files[x]}-waifu2x.png
done
