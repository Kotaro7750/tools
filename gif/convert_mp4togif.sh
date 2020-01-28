#!/bin/sh

CMDNAME="gif.sh"
TMP_FILE="tmp.mp4"
PALLETE="pallete.png"

while getopts s:t:f:p:o: OPT
do
  case "$OPT" in
    "s") FLG_S="TRUE";VALUE_S="$OPTARG";;
    "t") FLG_T="TRUE";VALUE_T="$OPTARG";;
    "f") FLG_F="TRUE";VALUE_F="$OPTARG";;
    "p") FLG_P="TRUE";VALUE_P="$OPTARG";;
    "o") FLG_O="TRUE";VALUE_O="$OPTARG";;
    *) echo "USAGE $CMDNAME [-s {start time}] [-t {duration time}] [-f {input file}] [-p {fps}] [-o {output file}]" 1>&2
      exit 1;;
  esac
done

if [ "$FLG_S" = "TRUE" ]; then
  START_TIME=$VALUE_S
fi

if [ "$FLG_T" = "TRUE" ]; then
  DURATION_TIME=$VALUE_T
fi

if [ "$FLG_F" = "TRUE" ]; then
  FILE=$VALUE_F
fi

if [ "$FLG_P" = "TRUE" ]; then
  FPS=$VALUE_P
fi

if [ "$FLG_O" = "TRUE" ]; then
  OUTPUT_FILE=$VALUE_O
fi

if [ "$FLG_S" = "TRUE" ] && [ "$FLG_T" = "TRUE" ]; then
  ffmpeg -ss $START_TIME -i $FILE -t $DURATION_TIME -y $TMP_FILE
  FILE=$TMP_FILE
fi

ffmpeg -i $FILE  -vf "palettegen" -y $PALLETE

ffmpeg -i $FILE -i $PALLETE -lavfi "fps=$FPS,scale=900:-1:flags=lanczos [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y $OUTPUT_FILE

rm $PALLETE
if [ "$FLG_S" = "TRUE" ] && [ "$FLG_T" = "TRUE" ]; then
  rm $TMP_FILE
fi
