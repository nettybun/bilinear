#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "simple.h"

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

#define p00 src->data[y0 * src->width + x0]
#define p10 src->data[y0 * src->width + (x0 + 1)]
#define p01 src->data[(y0 + 1) * src->width + x0]
#define p11 src->data[(y0 + 1) * src->width + (x0 + 1)]

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

      dst->data[(y * dst->width) + x] =
          ((
               p00 * (FPU_FACTOR - fracx) * (FPU_FACTOR - fracy) +
               p10 * fracx * (FPU_FACTOR - fracy) +
               p01 * (FPU_FACTOR - fracx) * fracy +
               p11 * fracx * fracy +
               (FPU_FACTOR * FPU_FACTOR / 2)) >>
           (2 * SHIFT));
    }
  }
}

// s + (e - s) * t

// A: p00 + (p10 - p00) * fracx
// B: p01 + (p11 - p01) * fracx
// C: A + (B - A) * fracy

// p00 + p10X - p00X + p01Y + p11XY - p01XY - p00Y + p10XY - p00XY

// p00   - p00X   - p00Y - p00XY +
// p10X  + p10XY  +
// p01Y  - p01XY  +
// p11XY

// p00 * (1 - X - Y - XY) +
// p10 * (X + XY) +
// p01 * (Y - XY) +
// p11 * (XY)

// p00 * (FPU_FACTOR - fracx) * (FPU_FACTOR - fracy) +
// p10 * fracx * (FPU_FACTOR - fracy) +
// p01 * (FPU_FACTOR - fracx) * fracy +
// p11 * fracx * fracy +

// p00 * (FAC^2 - FAC(X - Y) + XY) +
// p10 * (fracx*FAC - XY) +
// p01 * (fracy*FAC - XY) +
// p11 * (XY) +

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
