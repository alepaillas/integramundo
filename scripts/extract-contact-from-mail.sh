#!/bin/bash

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"
#echo "$wd"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -iname "*.html") )
#echo "$files"

i=$(echo "${#files[@]}" | bc)
for ((x=0; x < i; x++)); do
    printf "Nombre:\t\t"
    # sed black magic
    grep "Nombre" "${files[x]}" | html2text | head -n 1 | sed -e 's/^[^[:space:]]*[[:space:]]*//'
    printf "Whatsapp:\t "
    grep "Nombre" "${files[x]}" | html2text | tail -n 1 | sed -e 's/^[^[:space:]]*[[:space:]]*//'
    printf "Mensaje:\t"
    grep "Mensaje" "${files[x]}" | html2text | sed -e 's/^[^[:space:]]*[[:space:]]*//'
done