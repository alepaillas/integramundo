#!/bin/bash

# depends on
# https://github.com/nadermx/backgroundremover

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

# bash array
files=( $(find . -type f ! -name "$controlchars" -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg") )

#echo "$files"

i=$(echo "${#files[@]}" | bc)

for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	
	# can't operate on the same file it has to create a copy
	backgroundremover -i "${files[x]}" -o "${files[x]}-nobg.png"
done
