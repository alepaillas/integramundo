#!/bin/bash

# depends on
# - inkscape

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

# bash array
files=( $(find . -type f ! -name "$controlchars" -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg") )
#echo "$files"

i=$(echo "${#files[@]}" | bc)

for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"
 
	images=( $(inkscape --query-all ${files[x]} | sed -e 's/,.*//') )
  echo "$images"
  
  j=$(echo "${#files[@]}" | bc)
  
  for ((y=0; y < j; y++)); do
    #inkscape --export-type="svg" --export-id="${images[y]}" --export-id-only ${files[x]} -o ${images[y]}.svg
  done
done
