# 440

Optimizing image resizing and interpolation for ARM.

```sh
./run.sh
```

That's it.

There's a special binary file format of `*.simple` that's easy to hexdump and
inspect for humans and easy for the `./scale` program to process:

Format of _.simple_ files:

```
<WIDTH(uint32_t)><HEIGHT(uint32_t)><DATA(*uint8_t)>
```

This way, any image format can be converted to the simple format. Right now I
have converters to and from BMP. See the example files.

All BMP code is from:
https://github.com/yunghsianglu/IntermediateCProgramming/tree/master/Ch23

The initial bilinear interpolation code is from Rosetta Code:
https://rosettacode.org/wiki/Bilinear_interpolation#C
