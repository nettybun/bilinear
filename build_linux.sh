#!/usr/bin/env bash

set -x
mkdir -p bin
gcc -O3 -Wall bmp_to_simple_convert.c bmp.c simple.c -o bin/bmp_to_simple_convert
gcc -O3 -Wall simple_to_bmp_convert.c bmp.c simple.c -o bin/simple_to_bmp_convert
gcc -O3 -Wall scale.c simple.c -o bin/scale

#arm-linux-gnueabi-gcc -march=armv7-a -mfloat-abi=softfp -mfpu=neon -S scale.c