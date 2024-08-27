#!/bin/bash

# AAC_ENCODER=libfdk_aac
AAC_ENCODER=aac

MP4_ENCODER=libopenh264
#MP4_ENCODER=libx264

AUDIO_PARAMS="-c:a $AAC_ENCODER -profile:a aac_low -b:a 384k"
#AUDIO_PARAMS="-c:a copy"
VIDEO_PARAMS="-pix_fmt yuv420p -c:v $MP4_ENCODER -profile:v high -preset slow -crf 24 -g 29.97 -bf 2"
#VIDEO_PARAMS="-pix_fmt yuv420p -c:v $MP4_ENCODER -profile:v high -preset slow -crf 18 -g 12 -bf 2"
CONTAINER_PARAMS="-movflags faststart"

# denoise + sharpen
VIDEO_FILTERS="hqdn3d , unsharp=3:3:1.5"
AUDIO_FILTERS="loudnorm=I=-16:LRA=11:TP=-1.5"

# You need to adjust the GOP length to fit your source video.
# 60 fps -> -g 30
# 23.976 (24000/1001) -> -g 24000/1001/2  (???) <- plz comment
# 29.970 (30000/1001) -> -g (30000/1001/2) = 14.985

# ffmpeg -i "$1" $AUDIO_PARAMS $VIDEO_PARAMS $CONTAINER_PARAMS "$2"
# ffmpeg -i "$1" $AUDIO_PARAMS $VIDEO_PARAMS -vf "hqdn3d" $CONTAINER_PARAMS "$2"

#ffmpeg -framerate 29.97 -pattern_type glob -i "*.png" -i "$1" $AUDIO_PARAMS -shortest $VIDEO_PARAMS -vf "$FILTERS" $CONTAINER_PARAMS "$2"
#ffmpeg -i "$1" $AUDIO_PARAMS $VIDEO_PARAMS -vf "$FILTERS" $CONTAINER_PARAMS "$2"
#ffmpeg -framerate 30 -pattern_type glob -i "*.png" $AUDIO_PARAMS -shortest $VIDEO_PARAMS -vf "hqdn3d , unsharp=3:3:1.5" $CONTAINER_PARAMS "$1"

#ffmpeg -i "$1" -c:v copy $AUDIO_PARAMS -af loudnorm=I=-16:LRA=11:TP=-1.5 $CONTAINER_PARAMS "$1"-normalized-audio.mp4

ffmpeg -framerate 59.94 -pattern_type glob -i "*.jpg" -i audio.flac $AUDIO_PARAMS -af "$AUDIO_FILTERS" -shortest $VIDEO_PARAMS -vf "$VIDEO_FILTERS" $CONTAINER_PARAMS out.mp4

#ffmpeg -i "$1" $VIDEO_PARAMS -vf "$VIDEO_FILTERS" $AUDIO_PARAMS -af "$AUDIO_FILTERS" $CONTAINER_PARAMS "$2"
