#!/bin/bash

# AAC_ENCODER=libfdk_aac
AAC_ENCODER=aac

AUDIO_PARAMS="-c:a $AAC_ENCODER -profile:a aac_low -b:a 384k"
VIDEO_PARAMS="-pix_fmt yuv420p -c:v libx264 -profile:v high -preset slow -crf 18 -g 14.985 -bf 2"
CONTAINER_PARAMS="-movflags faststart"

# You need to adjust the GOP length to fit your source video.
# 60 fps -> -g 30
# 23.976 (24000/1001) -> -g 24000/1001/2  (???) <- plz comment
# 29.970 (30000/1001) -> -g (30000/1001/2) = 14.985

# ffmpeg -i "$1" $AUDIO_PARAMS $VIDEO_PARAMS $CONTAINER_PARAMS "$2"
# ffmpeg -i "$1" $AUDIO_PARAMS $VIDEO_PARAMS -vf "hqdn3d" $CONTAINER_PARAMS "$2"
ffmpeg -framerate 29.97 -pattern_type glob -i "*.png" -i "$1" $AUDIO_PARAMS -shortest $VIDEO_PARAMS -vf "hqdn3d , unsharp=3:3:1.5" $CONTAINER_PARAMS "$2"
