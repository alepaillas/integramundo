ffmpeg -ss 00:00:05 -to 00:01:49 -i "$1" -c:v copy -c:a copy out-trimmed.mp4
