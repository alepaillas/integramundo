#!/bin/bash

# depends on
# - imagemagick
# - jpegoptim

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png") )

echo "$files"

mkdir "$wd"/optimized-jpg

i=$(echo "${#files[@]}" | bc)

for ((x=0; x < i; x++)); do
	echo "Processing ${files[x]}"

	convert "${files[x]}" -sampling-factor 4:2:0 -define jpeg:dct-method=float -interlace Plane -colorspace sRGB -quality 30% "$wd"/optimized-jpg/"${files[x]}".jpg
	jpegoptim --strip-all --all-progressive "$wd"/optimized-jpg/"${files[x]}".jpg
	
	#convert "${files[x]}" "$wd"/optimized-jpg/"${files[x]}"1.jpg

	#cp "$wd"/optimized-jpg/"${files[x]}"1.jpg "$wd"/optimized-jpg/"${files[x]}"2.jpg

	#jpegoptim --strip-all --all-progressive -m 20 "$wd"/optimized-jpg/"${files[x]}"2.jpg
	#jpegoptim --strip-all --all-progressive --size 60kb "$wd"/optimized-jpg/"${files[x]}"2.jpg
	#jpegoptim --strip-all --all-progressive -m 14 "$wd"/optimized-jpg/"${files[x]}"2.jpg

	#convert "$wd"/optimized-jpg/"${files[x]}"2.jpg -sampling-factor 4:2:0 -define jpeg:dct-method=float -interlace Plane -colorspace sRGB -blur 5x3 -quality 20% "$wd"/optimized-jpg/"${files[x]}"3.jpg

	#cp "$wd"/optimized-jpg/"${files[x]}"3.jpg "$wd"/optimized-jpg/"${files[x]}"4.jpg

	#jpegoptim --strip-all --all-progressive --size 40kb "$wd"/optimized-jpg/"${files[x]}"4.jpg
	#jpegoptim --strip-all --all-progressive -m 10 "$wd"/optimized-jpg/"${files[x]}"4.jpg
done
