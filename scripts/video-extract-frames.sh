#!/bin/bash

# Change 'input.mp4' to the path of your video file
input_video="$1"

# Change 'frames' to your desired output folder name
output_folder="frames"

# Check if output folder exists, create it if not
if [ ! -d "$output_folder" ]; then
  mkdir -p "$output_folder"
fi

# Extract frames with zero-padded numbering
ffmpeg -i "$input_video" "$output_folder/%05d.png"

echo "Frames extracted to folder: $output_folder"
