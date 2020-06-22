#!/bin/bash
./build.sh
[ $? == 1 ] && exit 1

for file in ./images/*.bmp; do
  echo "BMP to Simple: $file"
  ./bin/bmp_to_simple_convert $file
done

ls -lsh ./images/
echo

mkdir -p images/simple
for file in ./images/*.simple; do
  mv $file ./images/simple/
  NAME=$(basename $file)
  echo "Simple to BMP (New directory): $NAME"
  ./bin/simple_to_bmp_convert ./images/simple/$NAME
done
