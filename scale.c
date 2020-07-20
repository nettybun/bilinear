#ifndef __ARM_FP
// VSCode doesn't autocomplete because my system is x86 and the .h is disabled
#define __ARM_FP 1
#endif
#include <arm_neon.h>
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
// 2^11 = 2048
#define SHIFT 11

#define p00 src->data[y0 * src->width + x0]
#define p01 src->data[(y0 + 1) * src->width + x0]
#define p10 src->data[y0 * src->width + (x0 + 1)]
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
               p01 * (FPU_FACTOR - fracx) * fracy +
               p10 * fracx * (FPU_FACTOR - fracy) +
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
// p01Y  - p01XY  +
// p10X  + p10XY  +
// p11XY

// p00 * (1 - X - Y - XY) +
// p01 * (Y - XY) +
// p10 * (X + XY) +
// p11 * (XY)

// p00 * (FPU_FACTOR - fracx) * (FPU_FACTOR - fracy) +
// p01 * (FPU_FACTOR - fracx) * fracy +
// p10 * fracx * (FPU_FACTOR - fracy) +
// p11 * fracx * fracy +

// p00 * (FAC^2 - FAC(X - Y) + XY) +
// p01 * (fracy*FAC - XY) +
// p10 * (fracx*FAC - XY) +
// p11 * (XY) +
// XXX: No. It's not equivalent algebra but it's the original mathematical
// equation for linear interpolation

// These #define statements are to have less typing later on

#define v_p00 v_neighbours.val[0]
#define v_p01 v_neighbours.val[1]
#define v_p10 v_neighbours.val[2]
#define v_p11 v_neighbours.val[3]

#define v_ifx v_fracs_inverse.val[0]
#define v_fx v_fracs.val[0]
#define v_ify v_fracs_inverse.val[1]
#define v_fy v_fracs.val[1]

void scale_neon(SIMPLE_Image* src, SIMPLE_Image* dst, float scale_factor) {
  const int dst_width_scaled = src->width * scale_factor;
  const int dst_height_scaled = src->height * scale_factor;
  const int x_ratio_scaled = (int)((double)FPU_FACTOR * src->width / dst_width_scaled + 0.5);    // FPU_FACTOR * src->width / dst_width_scaled;
  const int y_ratio_scaled = (int)((double)FPU_FACTOR * src->height / dst_height_scaled + 0.5);  // FPU_FACTOR * src->height / dst_height_scaled;

  uint32x4_t acc;
  uint32x4x2_t v_fracs_inverse;
  const uint32_t FPU_FACTOR_QUAD[4] = {FPU_FACTOR, FPU_FACTOR, FPU_FACTOR, FPU_FACTOR};
  uint32x4_t V_FPU_FACTOR = vld1q_u32(FPU_FACTOR_QUAD);

  int x, y, n = 0;
  for (y = 0; y < dst->height; y++) {
    int sy = y * y_ratio_scaled;
    int y0 = sy >> SHIFT;
    uint32_t fracy = sy - (y0 << SHIFT);

    for (x = 0; x < dst->width; x++) {
      int sx = x * x_ratio_scaled;
      int x0 = sx >> SHIFT;
      uint32_t fracx = sx - (x0 << SHIFT);

      uint32_t neighbours[4] = {p00, p01, p10, p11};
      uint32_t fracs[2] = {fracx, fracy};
      uint32x4x4_t v_neighbours = vld4q_u32(&neighbours);
      uint32x4x2_t v_fracs = vld2q_u32(&fracs);

      v_ifx = vmlsq_u32(V_FPU_FACTOR, v_fx, V_FPU_FACTOR);
      v_ify = vmlsq_u32(V_FPU_FACTOR, v_fy, V_FPU_FACTOR);

      // y0,x0 * ifx * ify
      acc = vmulq_u32(v_p00, vmulq_u32(v_ifx, v_ify));
      // y0,x0+1 * ifx * fy
      acc = vmlaq_u32(acc, v_p01, vmulq_u32(v_ifx, v_fy));
      // y0+1,x0 * fx * ify
      acc = vmlaq_u32(acc, v_p10, vmulq_u32(v_fx, v_ify));
      // y0+1,x0+1 * fx * fy
      acc = vmlaq_u32(acc, v_p11, vmulq_u32(v_fx, v_fy));

      // XXX: Might safe one multiplication if it was an incrementing pixel `n`
      vst1q_u32(dst->data[(y * dst->width) + x], acc);
    }
  }
}

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
