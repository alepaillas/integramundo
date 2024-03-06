ffmpeg -ss 00:00:00 -to 00:00:30 -i "$1" -c:v copy -c:a copy out-trimmed.mp4
