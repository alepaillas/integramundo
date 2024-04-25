#!/bin/bash

# depends on
# - imagemagick
# - vtracer

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"
#echo "$wd"

mkdir "$wd"/vectorized

convert $1 -blur 0x0.5 "$wd"/vectorized/$1-blurry.png
vtracer --input "$wd"/vectorized/$1-blurry.png \
	--filter_speckle 16 \
	--color_precision 7 \
	--gradient_step 64 \
	--mode polygon \
	--output "$wd"/vectorized/$1.svg
