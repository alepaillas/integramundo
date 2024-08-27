#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.JPG" -o -iname "*.jpeg" ) )
#echo "$files"

mkdir "$wd"/added-fg

i=$(echo "${#files[@]}" | bc)

for ((x=0; x < i; x++)); do
	echo "Adding foreground image to ${files[x]}"
	#convert -composite -gravity center "${files[x]}" logo.png "${files[x]}-logo.png"
	#convert -composite -gravity center "${files[x]}" /mnt/usb/work/img-db/logo.png "$wd"/added-fg/"${files[x]}"
	convert -composite -gravity center "${files[x]}" /mnt/d/work/img-db/logo.png "$wd"/added-fg/"${files[x]}"
done
