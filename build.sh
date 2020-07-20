#!/bin/bash
set -x
mkdir -p bin
gcc -g bmp_to_simple_convert.c bmp.c simple.c -o bin/bmp_to_simple_convert
gcc -g simple_to_bmp_convert.c bmp.c simple.c -o bin/simple_to_bmp_convert
gcc -g scale.c simple.c -o bin/scale

# arm-linux-gnueabi-gcc -march=armv7-a -mfloat-abi=softfp -mfpu=neon -S scale.c
