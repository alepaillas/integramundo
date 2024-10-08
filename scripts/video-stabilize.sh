#!/bin/bash

# AAC_ENCODER=libfdk_aac
AAC_ENCODER=aac
#MP4_ENCODER=libopenh264
MP4_ENCODER=libx264

VIDEO_PARAMS="-pix_fmt yuv420p -c:v $MP4_ENCODER -profile:v high -preset slow -crf 24 -g 15 -bf 2"
AUDIO_PARAMS="-c:a $AAC_ENCODER -profile:a aac_low -b:a 384k"
CONTAINER_PARAMS="-movflags faststart"

# You need to adjust the GOP length to fit your source video.
# 60 fps -> -g 30
# 23.976 (24000/1001) -> -g 24000/1001/2  (???) <- plz comment
# 29.970 (30000/1001) -> -g (30000/1001/2) = 14.985

# ffmpeg -i "$1" $AUDIO_PARAMS $VIDEO_PARAMS $CONTAINER_PARAMS "$2"
# ffmpeg -i "$1" $AUDIO_PARAMS $VIDEO_PARAMS -vf "hqdn3d" $CONTAINER_PARAMS "$2"
# ffmpeg -framerate 29.97 -pattern_type glob -i "*.png" -i "$1" $AUDIO_PARAMS -shortest $VIDEO_PARAMS -vf "hqdn3d" $CONTAINER_PARAMS "$2"

ffmpeg -i "$1" -vf vidstabdetect=shakiness=10 -f null -

ffmpeg -i "$1" $AUDIO_PARAMS $VIDEO_PARAMS -vf vidstabtransform=smoothing=5:zoom=0:input="transforms.trf" $CONTAINER_PARAMS "$1"-stab.mp4
