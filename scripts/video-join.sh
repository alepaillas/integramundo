#!/bin/bash

# Check if two input arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input1.mp4 input2.mp4"
    exit 1
fi

# Assign input arguments to variables
input1="$1"
input2="$2"

# Check if input files exist
if [ ! -f "$input1" ] || [ ! -f "$input2" ]; then
    echo "Input file does not exist!"
    exit 1
fi

# Create a temporary file listing the input videos in the current working directory
tempfile=$(mktemp --tmpdir=. --suffix=.txt)
echo "file '$input1'" > "$tempfile"
echo "file '$input2'" >> "$tempfile"

# Concatenate videos using ffmpeg
ffmpeg -f concat -safe 0 -i "$tempfile" -c copy "$input1"-"$input2"-join.mkv

# Remove temporary file
rm "$tempfile"

echo "Videos joined successfully!"
