#!/bin/bash
./build.sh
[ $? == 1 ] && exit 1

# Forward test
for file in ./images/*.bmp; do
  echo "BMP to Simple: $file"
  ./bin/bmp_to_simple_convert $file
done
echo

# Reverse test
mkdir -p images/simple
for file in ./images/*.simple; do
  mv $file ./images/simple/
  IMG_NAME=$(basename $file .simple)
  PATH_NAME="./images/simple/${IMG_NAME}-reverse.simple"
  echo "Simple to BMP: $PATH_NAME"
  ./bin/simple_to_bmp_convert $PATH_NAME
done
echo

# Scale test
for file in ./images/simple/*.simple; do
  for scale in $(seq 0.25 0.25 1); do
    IMG_NAME=$(basename $file .simple)
    PATH_NAME="./images/simple/${IMG_NAME}-${scale}x.simple"
    echo "Scale test: $scale $PATH_NAME"
    ./bin/scale $file $PATH_NAME $scale
    ./bin/simple_to_bmp_convert $PATH_NAME
  done;
  echo
done
echo "Done"
