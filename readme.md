# 440

Optimizing image resizing and interpolation for ARM.

```sh
./run.sh
```

That's it. The expected output on your machine is pasted below as well...

There's a special binary file format of `*.simple` that's easy to hexdump and
inspect for humans and easy for the `./scale` program to process:

## Format of _.simple_ files

```
<WIDTH(uint32_t)><HEIGHT(uint32_t)><DATA(*uint8_t)>
```

This way, any image format can be converted to the simple format. Right now I
have converters to and from BMP. See the example files.

## References

All BMP code is from:
https://github.com/yunghsianglu/IntermediateCProgramming/tree/master/Ch23

The initial bilinear interpolation code is from Rosetta Code:
https://rosettacode.org/wiki/Bilinear_interpolation#C

http://www.tech-algorithm.com/articles/bilinear-image-scaling/

## `./run.sh`

Note that if you're cross compiling do

```
arm-linux-gnueabi-gcc -march=armv7-a -mfloat-abi=softfp -mfpu=neon -S scale.c
```

```
+ mkdir -p bin
+ gcc -g bmp_to_simple_convert.c bmp.c simple.c -o bin/bmp_to_simple_convert
+ gcc -g simple_to_bmp_convert.c bmp.c simple.c -o bin/simple_to_bmp_convert
+ gcc -g scale.c simple.c -o bin/scale

BMP to Simple: ./images/pigs.bmp
BMP to Simple: ./images/text-diagram.bmp
BMP to Simple: ./images/twofiftysix-colours.bmp
BMP to Simple: ./images/w3c.bmp

Simple to BMP: ./images/simple/pigs-reverse.simple
Simple to BMP: ./images/simple/text-diagram-reverse.simple
Simple to BMP: ./images/simple/twofiftysix-colours-reverse.simple
Simple to BMP: ./images/simple/w3c-reverse.simple

Scale test: 0.25 ./images/simple/pigs-0.25x.simple
Scale test: 0.50 ./images/simple/pigs-0.50x.simple
Scale test: 0.75 ./images/simple/pigs-0.75x.simple
Scale test: 1.00 ./images/simple/pigs-1.00x.simple

Scale test: 0.25 ./images/simple/text-diagram-0.25x.simple
Scale test: 0.50 ./images/simple/text-diagram-0.50x.simple
Scale test: 0.75 ./images/simple/text-diagram-0.75x.simple
Scale test: 1.00 ./images/simple/text-diagram-1.00x.simple

Scale test: 0.25 ./images/simple/twofiftysix-colours-0.25x.simple
Scale test: 0.50 ./images/simple/twofiftysix-colours-0.50x.simple
Scale test: 0.75 ./images/simple/twofiftysix-colours-0.75x.simple
Scale test: 1.00 ./images/simple/twofiftysix-colours-1.00x.simple

Scale test: 0.25 ./images/simple/w3c-0.25x.simple
Scale test: 0.50 ./images/simple/w3c-0.50x.simple
Scale test: 0.75 ./images/simple/w3c-0.75x.simple
Scale test: 1.00 ./images/simple/w3c-1.00x.simple

Done
```
