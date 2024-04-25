#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_file> <start_time> <end_time>"
    exit 1
fi

# Input arguments
input_file="$1"
start_time="$2"
end_time="$3"

# Function to get the duration of the input video
get_duration() {
    duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$1")
    echo "$duration"
}

# Calculate the duration of the input video
duration=$(get_duration "$input_file")

# If the end time is set to "end", set it to the duration of the video
if [ "$end_time" = "end" ]; then
    end_time="$duration"
fi

# Run ffmpeg command
ffmpeg -ss "$start_time" -to "$end_time" -i "$input_file" -c:v copy -c:a copy "$input_file"-trimmed.mkv
