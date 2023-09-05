#!/bin/bash

# depends on
# https://github.com/nadermx/backgroundremover

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"

# bash array
files=( $(find . -type f ! -name "$controlchars" -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -iname "*.JPG") )
#echo "$files"

# no error if directory exists and creates parents
mkdir --parents "$wd"/bg-removed

i=$(echo "${#files[@]}" | bc)
for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
	
	# can't operate on the same file it has to create a copy
	backgroundremover -i "${files[x]}" -o "${files[x]}-nobg.png"
	mv "${files[x]}-nobg.png" "$wd/bg-removed/${files[x]}-nobg.png"
done
