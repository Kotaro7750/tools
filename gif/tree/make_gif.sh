#!/bin/sh 

MAX=`python3 ./biggest_size.py`
MAXWIDTH=`echo ${MAX} | sed -e 's/,.*//'`
MAXHEIGHT=`echo ${MAX} | sed -e 's/.*,//'`

for file in *.png
do
  FILE=${file%.*}.bmp
  convert ${file} $FILE
  convert $FILE -gravity west -background white -extent ${MAXWIDTH}x${MAXHEIGHT} $FILE
done

OFFSET_W=`python3 ./calc_offset.py`

for file in *.bmp
do
  ROOT=`python3 ./search_root.py ${file}`

  convert ${file} -distort Affine "${ROOT} ${OFFSET_W}" ${file}
done

convert -delay 50 -loop 0 *.bmp anim.gif
rm *.bmp
rm *.png
