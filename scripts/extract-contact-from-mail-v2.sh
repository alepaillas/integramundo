#!/bin/bash

# escape bad filenames
IFS="$(printf '\n\t')"
controlchars="$(printf '*[\001-\037\177]*')"

wd="$(pwd)"
#echo "$wd"

# bash array
files=( $(find . -maxdepth 1 -type f ! -name "$controlchars" -iname "*.eml") )
#echo "$files"

output_file="output.txt"

# awk 'NR % 2 == 1 { print $NF }'
# awk 'NR % 2 != 1 { print $NF }' mails.txt

i=$(echo "${#files[@]}" | bc)
for ((x=0; x < i; x++)); do
    printf "Nombre: "  >> "$output_file"
    grep "Nombre" "${files[x]}" | sed -e 's/=09.*$//' | sed -e 's/\*Nombre:\*//' | sed -e 's/^[^[:space:]]*[[:space:]]*//' >> "$output_file"
    printf "\n"  >> "$output_file"

    printf "Teléfono: "  >> "$output_file"
    grep "Tel" "${files[x]}" | sed -e 's/=09.*$//' | sed -e 's/\*Tel=C3=A9fono:\*//' | sed -e 's/^[^[:space:]]*[[:space:]]*//' >> "$output_file"
    printf "\n"  >> "$output_file"

    printf "Email: "  >> "$output_file"
    grep "Email" "${files[x]}" | sed -e 's/=09.*$//' | sed -e 's/\*Email:\*//' | sed -e 's/^[^[:space:]]*[[:space:]]*//' >> "$output_file"
    printf "\n"  >> "$output_file"

    printf "Conversación: "  >> "$output_file"
    grep "Cliente" "${files[x]}" | sed -e 's/=09.*$//' >> "$output_file"
    printf "\n"  >> "$output_file"
done