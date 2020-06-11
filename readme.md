# 440

All BMP code is from:
https://github.com/yunghsianglu/IntermediateCProgramming/tree/master/Ch23

The initial bilinear interpolation code is from Rosetta Code:
https://rosettacode.org/wiki/Bilinear_interpolation#C

```fish
gcc main.c bmp.c -o bmp
for i in (seq 0.1 0.1 2)
    echo $i
    ./bmp input.bmp output-resize-$i.bmp $i
end
```
