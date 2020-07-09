#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "simple.h"

uint8_t getpixel(SIMPLE_Image* img, unsigned int x, unsigned int y) {
  int pxl = ((y * img->width) + x);
  return img->data[pxl];
}

void putpixel(SIMPLE_Image* img, unsigned int x, unsigned int y, uint8_t color) {
  int pxl = ((y * img->width) + x);
  img->data[pxl] = color;
}

int lerp(int s, int e, int t) {
  return s + (e - s) * t;
}

int blerp(uint8_t c00, uint8_t c10, uint8_t c01, uint8_t c11, int tx, int ty) {
  return lerp(lerp(c00, c10, tx), lerp(c01, c11, tx), ty);
}

// Alright so lets avoid FPU
// If the src > dst like 400 -> 200 then pixel x must be mapped _down_ by the
// scale factor like 0.5. To avoid FPU we can multiply both src and dst such
// that the pixel is never a floating point.
// If the dst > src like 200 -> 400 then pixel x is never a floating point
// because the scale is >1
// To generally though, we can not just multiply by the scale factor (10, 100,
// etc) but just a large constant like 1000.

#define FPU_FACTOR 2048
#define SHIFT 11

void scale(SIMPLE_Image* src, SIMPLE_Image* dst, float scale_factor) {
  const int dst_width_scaled = src->width * scale_factor;
  const int dst_height_scaled = src->height * scale_factor;
  const int x_ratio_scaled = (int)((double)FPU_FACTOR * src->width / dst_width_scaled + 0.5);    // FPU_FACTOR * src->width / dst_width_scaled;
  const int y_ratio_scaled = (int)((double)FPU_FACTOR * src->height / dst_height_scaled + 0.5);  // FPU_FACTOR * src->height / dst_height_scaled;

  int x, y;
  for (y = 0; y < dst->height; y++) {
    int sy = y * y_ratio_scaled;
    int y0 = sy >> SHIFT;
    int fracy = sy - (y0 << SHIFT);

    for (x = 0; x < dst->width; x++) {
      int sx = x * x_ratio_scaled;
      int x0 = sx >> SHIFT;
      int fracx = sx - (x0 << SHIFT);

      uint8_t c00 = getpixel(src, x0, y0);
      uint8_t c10 = getpixel(src, x0 + 1, y0);
      uint8_t c01 = getpixel(src, x0, y0 + 1);
      uint8_t c11 = getpixel(src, x0 + 1, y0 + 1);
      // uint8_t result = (uint8_t)blerp(c00, c10, c01, c11, fracx, fracy);

      // Not convinced this will make any sense...
      uint8_t result = (
        (
          c00 * (FPU_FACTOR - fracx) * (FPU_FACTOR - fracy) +
          c10 * fracx * (FPU_FACTOR - fracy) +
          c01 * (FPU_FACTOR - fracx) * fracy +
          c11 * fracx * fracy +
          (FPU_FACTOR * FPU_FACTOR / 2)
        ) >> (2 * SHIFT)
      );
      putpixel(dst, x, y, result);
    }
  }
}

// int a = (
//     (
//         c1a * (FACTOR - fracx) * (FACTOR - fracy)
//       + c2a * fracx * (FACTOR - fracy)
//       + c3a * (FACTOR - fracx) * fracy
//       + c4a * fracx * fracy
//       + (FACTOR * FACTOR / 2)
//     ) >> (2 * SHIFT)
// );

// s + (e - s) * t => c00 + (c10 - c00) * fracx
// s + (e - s) * t => c01 + (c11 - c01) * fracy

int main(int argc, char** argv) {
  if (argc != 4) {
    printf("Usage: ./scale input.simple output.simple 0.5\n");
    return EXIT_FAILURE;
  }
  char* src_file = argv[1];
  char* dst_file = argv[2];
  float scale_factor = atof(argv[3]);

  SIMPLE_Image* src = SIMPLE_open(src_file);
  if (src == NULL) {
    return EXIT_FAILURE;
  }
  SIMPLE_Image* dst = SIMPLE_new(
      src->width * scale_factor,
      src->height * scale_factor);

  scale(src, dst, scale_factor);

  int status = SIMPLE_save(dst, dst_file);
  SIMPLE_destroy(src);
  SIMPLE_destroy(dst);
  return status;
}
