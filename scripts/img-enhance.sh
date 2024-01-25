#!/bin/bash

# depends on
# - imagemagick

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"
#echo "$wd"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg") )
#echo "$files"

i=$(echo "${#files[@]}" | bc)

mkdir "$wd"/enhanced-image

for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	#convert -enhance -equalize -contrast "${files[x]}" "${files[x]}"
	#convert -auto-gamma -auto-level -normalize "${files[x]}" "${files[x]}"
	#convert -auto-level "${files[x]}" "$wd"/edited-image/"${files[x]}"
	convert "${files[x]}" -channel green -evaluate multiply 0.90 +channel -normalize -auto-level -fill khaki1 -colorize 35% -brightness-contrast -20x10 "$wd"/enhanced-image/"${files[x]}"
	#convert "${files[x]}" -normalize -auto-level -brightness-contrast -2.5x1.25 "$wd"/enhanced-image/"${files[x]}"
done
