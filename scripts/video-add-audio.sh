#!/bin/bash

# Check if three arguments are provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 <video_file> <audio_file> <output_file>"
  exit 1
fi

# Get video, audio file paths and output filename
video_file="$1"
audio_file="$2"
output_file="$3"

# AAC_ENCODER=libfdk_aac  # You can uncomment for libfdk_aac (check compatibility)
AAC_ENCODER=aac

AUDIO_PARAMS="-c:a $AAC_ENCODER -profile:a aac_low -b:a 384k"

AUDIO_FILTERS="loudnorm=I=-16:LRA=11:TP=-1.5"

# Join video and audio streams using ffmpeg
ffmpeg -i "$video_file" -i "$audio_file" \
  -c:v copy \
  $AUDIO_PARAMS \
  -filter:a "$AUDIO_FILTERS" \
  -map 0:v -map 1:a  "$output_file"

# Check for successful execution
if [ $? -eq 0 ]; then
  echo "Video and audio joined successfully: $output_file"
else
  echo "Error joining video and audio!"
fi
