#!/bin/bash

if [ -z "$1" ] 
	then
    echo -e "\n\n[!] No directory of images supplied."
    exit
fi
echo "[+] Preparing images from $1"
cd $1
mkdir out

for f in $(find . -name '*.png'); do
  echo -e "\t[i] Converting: $f"
  w=`identify -format "%w" $f` # get width
  h=`identify -format "%h" $f` # get heigh
  sleep 1
  convert $f \
     \( +clone  -alpha extract \
        -draw 'fill black polygon 0,0 0,7 7,0 fill white circle 7,7 7,0' \
        \( +clone -flip \) -compose Multiply -composite \
        \( +clone -flop \) -compose Multiply -composite \
     \) -alpha off -compose CopyOpacity -composite out1.png
  sleep 1
  convert -page +4+4 out1.png -alpha set \
          \( +clone -background black -shadow 60x4+4+4 \) +swap \
          -background none -mosaic  out2.png
  sleep 1
  if [ "$w"  -lt  "$h" ]
	then
      convert ../white.png out2.png -resize 800x600 -gravity center -composite out3.png
  fi
  rm out1.png 
  if [ -f "out3.png" ]; then
    mv out3.png "out/$f"
    rm out2.png
  else
    mv out2.png "out/$f"
  fi

echo -e "\n[+] Done!"
done
