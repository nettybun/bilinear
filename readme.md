# 440

Optimizing image resizing and interpolation for ARM.

This was originally setup to read BMP but I wanted it to be one simple C file so
I split off the BMP functions into a separate file conv_bmp_bin.c that converts
colour BMPs to a grayscale binary of:

```
<WIDTH(uint32_t)><HEIGHT(uint32_t)><DATA(*uint8_t)>
```

From there we know there's W*H pixels in data. The bilinear function is ready to
read this data format. Finally, there's a conv_bin_bmp.c that write a grayscale BMP.

BMP doesn't support grayscale. It's always BGR colour codes. A grayscale BMP has
all colours the same such as 67,67,67,70,70,70,120,120,120... That's fine.

All BMP code is from:
https://github.com/yunghsianglu/IntermediateCProgramming/tree/master/Ch23

The initial bilinear interpolation code is from Rosetta Code:
https://rosettacode.org/wiki/Bilinear_interpolation#C


At 6f549d6c1a326dc26dc4978a8bec20491a55cb24 you could run this to generate all
the resizes for a given input.bmp

```fish
gcc main.c bmp.c -o bmp
for i in (seq 0.1 0.1 2)
    echo $i
    ./bmp input.bmp output-resize-$i.bmp $i
end
```
