#!/bin/bash

# depends on
# - imagemagick
# - waifu2x-converter-cpp

#waifu2x="/mnt/usb/work/programas/waifu2x-converter-cpp-win64_v534/waifu2x-converter-cpp.exe"
#models="/mnt/usb/work/programas/waifu2x-converter-cpp-win64_v534/models_rgb"

#waifu2x="waifu2x-converter-cpp"
waifu2x="waifu2x-ncnn-vulkan"

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
	$waifu2x -i ${files[x]} -o "$wd"/waifu2x/${files[x]}-waifu2x.png
done
