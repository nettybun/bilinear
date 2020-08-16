
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "simple.h"

/*
Since S3C440A CPU does not have any SIMD extension, we cannot perform any
vectorized implementaion using NEON. We can only perform such optimization which
will reduce numbers of instruction exectured, replace inefficient instruction
with their efficient version or reduce memory usage to decrease cache miss rate.
*/

// #define NAIVE /* simple, easy to understand floatin point implementation from http://www.tech-algorithm.com/articles/bilinear-image-scaling/ */
// #define OPTIMIZED_SCALAR_FLOATING_POINT /* Optimized floating point implementation */
// #define SCALAR_FIXED_POINT /* Implementation with introduced operators that to calculation in fixed point domain. */
// #define OPTIMIZED_SCALAR_FIXED_POINT /* Optimized implementation using fixed point calculations */
// #define VECTOR_EMU_FLOATING_POINT /* Floating point version showing how vectorized code looks like */
// #define VECTOR_EMU_FIXED_POINT /* Fixed point version showing how vectorized code looks like */
#define VECTOR_NEON_FIXED_POINT /* Fixed point version with added NEON intrinsics */

#ifdef NAIVE
void scale(SIMPLE_Image *src, SIMPLE_Image *dst, float scale_factor)
{
  uint32_t i, j;
  uint32_t k = 0;
  double scale = 1.0f / scale_factor;

  for (i = 0; i < dst->height; i++)
  {
    for (j = 0; j < dst->width; j++)
    {
      uint32_t x = (uint32_t)(scale * j);
      uint32_t y = (uint32_t)(scale * i);

      float xfrac = ((double)scale * j) - x;
      float yfrac = ((double)scale * i) - y;

      uint32_t index = x + y * src->width;

      uint8_t A = src->data[index];
      uint8_t B = src->data[index + 1];
      uint8_t C = src->data[index + src->width];
      uint8_t D = src->data[index + src->width + 1];

      uint8_t gray = (uint8_t)(A * (1.0f - xfrac) * (1.0f - yfrac) +
                               +B * xfrac * (1.0f - yfrac) +
                               +C * yfrac * (1.0f - xfrac) +
                               +D * xfrac * yfrac);
      dst->data[k++] = gray;
    }
  }
}
#endif
#ifdef OPTIMIZED_SCALAR_FLOATING_POINT
/*
In this implementation few optimizations happened:
- moved y and yfrac calculation to outer loop since it isn't correlated with
  variable i
- removed double because this CPU has only 32-bit register and to make algorithm
  faster, we must use only native types (such types that fit into CPU registers
  without any transform) because otherwise compiler will add many instruction
  that must handle 64-bit wide calculations.
- uint8_t type has been also removed from calculations as it also isn't native
  type for 32-bit architecture.
- for loops replaced by while(). Usually while loops are the fastests especially
  when condition inside them is as simple as possible. That's why I switch to
  iterating from the end of image.
*/
void scale(SIMPLE_Image *src, SIMPLE_Image *dst, float scale_factor)
{
  uint32_t i = dst->height, k = dst->height * dst->width - 1;
  uint32_t j;
  float scale = 1.0f / scale_factor;

  while (i--)
  {
    uint32_t y = (uint32_t)(scale * i);
    float yfrac = scale * i - y;
    j = dst->width;

    while (j--)
    {
      uint32_t x = (uint32_t)(scale * j);
      float xfrac = scale * j - x;
      float i_xfrac = 1.0f - xfrac;
      float i_yfrac = 1.0f - yfrac;
      uint32_t index = x + y * src->width;

      uint32_t A = src->data[index];
      uint32_t B = src->data[index + 1];
      uint32_t C = src->data[index + src->width];
      uint32_t D = src->data[index + src->width + 1];

      uint32_t gray = (uint32_t)(A * i_xfrac * i_yfrac +
                                 +B * xfrac * i_yfrac +
                                 +C * yfrac * i_xfrac +
                                 +D * xfrac * yfrac);
      dst->data[k--] = (uint8_t)gray;
    }
  }
}
#endif
#ifdef SCALAR_FIXED_POINT

/*
Since S3C440A does not have a floating-point unit, we should avoid any floating
point calculation since they won't have any hardware acceleration. Therefore we
need to make all calculation on integer values. In order to perform correctly
fractional calculations on integer values, we implement them using fixed-point
calculation. Good and simple explanation is here:
https://spin.atomicobject.com/2012/03/15/simple-fixed-point-math/

I have introduced new type called tQfract which will hold fractional value
represented by integer value. I also added basic operations on this type. In
order to mix fractional values and non-fractional values, I added conversions
between plain integer and fractional (represented by integer).

Value of Q_BITS must be high enough to maintain proper accuracy during
calculation but low enough to prevent from any overflow during multiplication.
*/

typedef uint32_t tQfract;
#define Q_BITS (16u)
#define Q_MAX ((tQfract)(1 << Q_BITS))
#define Q_FLOAT_TO_FIXED(a) ((tQfract)((float)a * Q_MAX))
#define Q_INT_TO_FRACT(a) ((tQfract)((a) << Q_BITS))
#define Q_FRACT_TO_INT(a) ((uint32_t)((a) >> Q_BITS))
#define Q_ADD(a, b) ((tQfract)(a) + (b))
#define Q_SUB(a, b) ((tQfract)(a) - (b))
#define Q_MUL(a, b) ((tQfract)(((uint64_t)a) * (b) >> Q_BITS))
#define Q_DOT4(a, b, c, d) ((tQfract)(a) + (b) + (c) + (d))
#define Q_10 Q_MAX

void scale(SIMPLE_Image *src, SIMPLE_Image *dst, float scale_factor)
{
  uint32_t i = dst->height, k = dst->height * dst->width - 1;
  uint32_t j;
  // float scale = 1.0f / scale_factor;
  uint32_t scale = Q_FLOAT_TO_FIXED(1.0f / scale_factor);

  while (i--)
  {
    // uint32_t y = (uint32_t)(scale * i);
    uint32_t y = Q_FRACT_TO_INT(Q_MUL(scale, Q_INT_TO_FRACT(i)));
    // float yfrac = scale * i - y;
    tQfract yfrac = Q_SUB(Q_MUL(scale, Q_INT_TO_FRACT(i)), Q_INT_TO_FRACT(y));
    j = dst->width;

    while (j--)
    {
      // uint32_t x = (uint32_t)(scale * j);
      uint32_t x = Q_FRACT_TO_INT(Q_MUL(scale, Q_INT_TO_FRACT(j)));
      // float xfrac = scale * j - x;
      tQfract xfrac = Q_SUB(Q_MUL(scale, Q_INT_TO_FRACT(j)), Q_INT_TO_FRACT(x));

      // float i_xfrac = 1.0f - xfrac;
      tQfract i_xfrac = Q_SUB(Q_10, xfrac);
      // float i_yfrac = 1.0f - yfrac;
      tQfract i_yfrac = Q_SUB(Q_10, yfrac);
      uint32_t index = x + y * src->width;

      uint32_t A = src->data[index];
      uint32_t B = src->data[index + 1];
      uint32_t C = src->data[index + src->width];
      uint32_t D = src->data[index + src->width + 1];

      // uint32_t gray = (uint32_t)(A * i_xfrac * i_yfrac +
      //               + B * xfrac * i_yfrac +
      //               + C * yfrac * i_xfrac +
      //               + D * xfrac * yfrac);
      uint32_t gray = Q_FRACT_TO_INT(
          Q_DOT4(
              Q_MUL(Q_INT_TO_FRACT(A), Q_MUL(i_xfrac, i_yfrac)), Q_MUL(Q_INT_TO_FRACT(B), Q_MUL(xfrac, i_yfrac)), Q_MUL(Q_INT_TO_FRACT(C), Q_MUL(yfrac, i_xfrac)), Q_MUL(Q_INT_TO_FRACT(D), Q_MUL(xfrac, yfrac))));
      dst->data[k--] = (uint8_t)gray;
    }
  }
}
#endif
#ifdef OPTIMIZED_SCALAR_FIXED_POINT

/*
This implemation behaves exactly like previous one BUT the main optimizaton here
was to remove unnecessarry shifting by Q_BITS. One good optimization here was to
tune Q_BITS in order to allow chained multiplication without additional
shifting. In this algorithm follwing multiplication chain is the longest: A *
i_xfrac * i_yfrac

It is dictating maximum Q_BITS value to allow 3 multiplication in a row without
shifting back and forth. There are 3 multiplication and the result cannot exceed
32 bits. We know that A,B,C,D will not be higher than 255.

So the biggest number X that will satisfy equation (255 * X * X < 2^32) is 2048.
Therefore 2048 will be our fractional scale. Higher number might produce
overflow, lower number will decreace accuracy.
*/

#define Q_BITS (11u)
#define Q_MAX ((uint32_t)(1 << Q_BITS))
#define Q_FLOAT_TO_FIXED(a) ((uint32_t)((float)a * Q_MAX))
#define Q_10 Q_MAX

void scale(SIMPLE_Image *src, SIMPLE_Image *dst, float scale_factor)
{
  uint32_t i = dst->height, k = dst->height * dst->width - 1;
  uint32_t j;
  // float scale = 1.0f / scale_factor;
  uint32_t scale = Q_FLOAT_TO_FIXED(1.0f / scale_factor);

  while (i--)
  {
    // uint32_t y = (uint32_t)(scale * i);
    uint32_t y = (scale * i) >> Q_BITS;
    // float yfrac = scale * i - y;
    uint32_t yfrac = (scale * i) - (y << Q_BITS);
    // float i_yfrac = 1.0f - yfrac;
    uint32_t i_yfrac = Q_10 - yfrac;
    j = dst->width;

    while (j--)
    {
      // uint32_t x = (uint32_t)(scale * j);
      uint32_t x = (scale * j) >> Q_BITS;
      // float xfrac = scale * j - x;
      uint32_t xfrac = (scale * j) - (x << Q_BITS);

      // float i_xfrac = 1.0f - xfrac;
      uint32_t i_xfrac = Q_10 - xfrac;

      uint32_t index = x + y * src->width;

      uint32_t A = src->data[index];
      uint32_t B = src->data[index + 1];
      uint32_t C = src->data[index + src->width];
      uint32_t D = src->data[index + src->width + 1];

      // uint32_t gray = (uint32_t)(A * i_xfrac * i_yfrac +
      //               + B * xfrac * i_yfrac +
      //               + C * yfrac * i_xfrac +
      //               + D * xfrac * yfrac);
      uint32_t gray = (uint32_t)(A * i_xfrac * i_yfrac +
                                 +B * xfrac * i_yfrac +
                                 +C * yfrac * i_xfrac +
                                 +D * xfrac * yfrac) >>
                      (Q_BITS + Q_BITS);
      dst->data[k--] = (uint8_t)gray;
    }
  }
}
#endif
#ifdef VECTOR_EMU_FLOATING_POINT
void scale(SIMPLE_Image *src, SIMPLE_Image *dst, float scale_factor)
{
  uint32_t i, j;
  uint32_t k = 0;
  const float scale = 1.0f / scale_factor;
  const float v_const0[2] = {1.0f, -1.0f};
  const float v_const1[2] = {1.0f, 0.0f};

  for (i = 0; i < dst->height; i++)
  {
    uint32_t y = (uint32_t)(scale * i);
    float yfrac = scale * i - y;
    float i_yfrac = 1.0f - yfrac;
    uint32_t y_offset = y * src->width;

    for (j = 0; j < dst->width; j++)
    {
      uint32_t x = (uint32_t)(scale * j);
      float xfrac = scale * j - x;
      uint32_t index = x + y_offset;

      uint32_t v_src0[2], v_src1[2];
      float v_weight0[2], v_weight1[2];
      uint32_t gray;

      v_src0[0] = src->data[index];
      v_src0[1] = src->data[index + 1];
      v_src1[0] = src->data[index + src->width];
      v_src1[1] = src->data[index + src->width + 1];

      v_weight0[0] = xfrac;
      v_weight0[1] = xfrac;
      v_weight1[0] = xfrac;
      v_weight1[1] = xfrac;

      v_weight0[0] = v_weight0[0] * v_const0[0];
      v_weight0[1] = v_weight0[1] * v_const0[1];
      v_weight1[0] = v_weight1[0] * v_const0[0];
      v_weight1[1] = v_weight1[1] * v_const0[1];

      v_weight0[0] = v_const1[0] - v_weight0[0];
      v_weight0[1] = v_const1[1] - v_weight0[1];
      v_weight1[0] = v_const1[0] - v_weight1[0];
      v_weight1[1] = v_const1[1] - v_weight1[1];

      v_weight0[0] = v_weight0[0] * i_yfrac;
      v_weight0[1] = v_weight0[1] * i_yfrac;
      v_weight1[0] = v_weight1[0] * yfrac;
      v_weight1[1] = v_weight1[1] * yfrac;

      v_src0[0] = v_src0[0] * v_weight0[0];
      v_src0[1] = v_src0[1] * v_weight0[1];
      v_src1[0] = v_src1[0] * v_weight1[0];
      v_src1[1] = v_src1[1] * v_weight1[1];

      gray = v_src0[0] + v_src1[0] +
             +v_src0[1] + v_src1[1];

      dst->data[k++] = (uint8_t)gray;
    }
  }
}
#endif
#ifdef VECTOR_EMU_FIXED_POINT

#define Q_BITS (11u)
#define Q_MAX ((uint32_t)(1 << Q_BITS))
#define Q_FLOAT_TO_FIXED(a) ((uint32_t)((float)a * Q_MAX))
#define Q_10 Q_MAX

void scale(SIMPLE_Image *src, SIMPLE_Image *dst, float scale_factor)
{
  int32_t i, j, k = 0;
  int32_t scale = Q_FLOAT_TO_FIXED(1.0f / scale_factor);
  const int32_t v_const0[2] = {1, -1};
  const int32_t v_const1[2] = {Q_10, 0};

  for (i = 0; i < dst->height; i++)
  {
    int32_t y = (scale * i) >> Q_BITS;
    int32_t yfrac = (scale * i) - (y << Q_BITS);
    int32_t i_yfrac = Q_10 - yfrac;

    for (j = 0; j < dst->width; j++)
    {
      int32_t x = (scale * j) >> Q_BITS;
      int32_t xfrac = (scale * j) - (x << Q_BITS);
      int32_t index = x + y * src->width;

      int32_t v_src0[2], v_src1[2];
      int32_t v_weight0[2], v_weight1[2];
      int32_t gray;

      // Vector load from memory
      v_src0[0] = src->data[index];
      v_src0[1] = src->data[index + 1];
      v_src1[0] = src->data[index + src->width];
      v_src1[1] = src->data[index + src->width + 1];

      // Vector load with constant
      v_weight0[0] = xfrac;
      v_weight0[1] = xfrac;
      v_weight1[0] = xfrac;
      v_weight1[1] = xfrac;

      // Vector multiply
      v_weight0[0] = v_weight0[0] * v_const0[0];
      v_weight0[1] = v_weight0[1] * v_const0[1];
      v_weight1[0] = v_weight1[0] * v_const0[0];
      v_weight1[1] = v_weight1[1] * v_const0[1];

      // Vector substract
      v_weight0[0] = v_const1[0] - v_weight0[0];
      v_weight0[1] = v_const1[1] - v_weight0[1];
      v_weight1[0] = v_const1[0] - v_weight1[0];
      v_weight1[1] = v_const1[1] - v_weight1[1];

      // Vector multiply
      v_weight0[0] = v_weight0[0] * i_yfrac;
      v_weight0[1] = v_weight0[1] * i_yfrac;
      v_weight1[0] = v_weight1[0] * yfrac;
      v_weight1[1] = v_weight1[1] * yfrac;

      // Vector multiply
      v_src0[0] = v_src0[0] * v_weight0[0];
      v_src0[1] = v_src0[1] * v_weight0[1];
      v_src1[0] = v_src1[0] * v_weight1[0];
      v_src1[1] = v_src1[1] * v_weight1[1];

      // Vector accross vector
      gray = v_src0[0] + v_src1[0] +
             +v_src0[1] + v_src1[1];

      gray >>= (Q_BITS + Q_BITS);

      dst->data[k++] = (uint8_t)gray;
    }
  }
}
#endif
#ifdef VECTOR_NEON_FIXED_POINT
#include <arm_neon.h>

/*
NEON:
- to process bigger chunks of continuous (!!) memory (up to 32 byte vectors)
  using single instructions
- to merge couple of instructions to one single. Operands should be independent
  for particular merging. My NEON-optimized version works by merging couple
  instruction in one.

Modern compilers like GCC or Clang are very good at auto-vectorizing code which
means that sometimes there's no real point of doing manual implementation. In
order to make the code "ready" for auto vectorize we must ensure that:
- we process continuous memory space and fixed chunks
- our most inner loop has compile-time known number of iterations
- data processed should as independent as possible to prevent wait states.

Here we have bilinear interpolation algorithm. It's a simple equation however
input memory is not continuous because we fetch two bytes from first row and
another two bytes from next row. Moreover, since we scale x and y, then make a
cast to int32_t, when scale is > 1.0, input data are not always updated. In
fact, we could read from memory only when pixel index reaches multiple of scale.
I didn't use that knowledge in the algorithm because most likely it won't affect
performance so much (except situation when we have large scaling factor and
loads will come once 5-10 pixel). Third thing which makes such code uneasy to
vectorize is the fact that it deals with uint8_t byte data. As I mentioned, best
case for CPU is to process data fitting ideally into its registers (which may be
32- or 64-bits long depending on ARM architecture). Pixel weighting is done on
32-bits and input data is 8 bit. In the NEON reference there isn't any
conversion intrinsic that could place each element from vector int8x8_t to
particular lane in vector. That make it hard to even load a int32x2_t vector
from (uint8_t *) because there isn't any dedicated hardware instruction to do it
within NEON instruction set. Still I managed to implement the thus algorightm
using NEON instructions and attached perf reports proving that NEON version is
5x faster than naive implementation.

There could be couple of things we could do to make those numbers even better:
- we could switch from storing gray pixels as uint8_t to uint32_t. That would
  greatly increase size of temporary image but that's how it is done in the
  industry: input data are converted into some native processing type which for
  efficient processing.
- we could store pixels inside SIMPLE_Image in a interleaved form:
  x_pix, x_pix+1, y_pix, y_pix+1 ...
  In this way we could load 4 pixels at once in speed up loading time
*/

#define Q_BITS (11u)
#define Q_MAX ((uint32_t)(1 << Q_BITS))
#define Q_FLOAT_TO_FIXED(a) ((uint32_t)((float)a * Q_MAX))
#define Q_10 Q_MAX

void scale(SIMPLE_Image *src, SIMPLE_Image *dst, float scale_factor)
{
  int32_t i, j, k = 0;
  int32_t scale = Q_FLOAT_TO_FIXED(1.0f / scale_factor);
  const int32x2_t v_const0 = {1, -1};
  const int32x2_t v_const1 = {Q_10, 0};

  for (i = 0; i < dst->height; i++)
  {
    int32_t y = (scale * i) >> Q_BITS;
    int32_t yfrac = (scale * i) - (y << Q_BITS);
    int32_t i_yfrac = Q_10 - yfrac;

    for (j = 0; j < dst->width; j++)
    {
      int32_t x = (scale * j) >> Q_BITS;
      int32_t xfrac = (scale * j) - (x << Q_BITS);
      int32_t index = x + y * src->width;

      int32x2_t v_src0, v_src1;
      int32x2_t v_weight0, v_weight1;
      int32_t gray;

      // Vector load from memory
      /* We are reading uint8_t data and storing it inside int32x2_t vector.
         Since there isn't any convenience NEON intrincs, I have used the same
         code as in above implementation. If Simple_Image would use 32-bit data,
         I could use of vld1_s32() intrinsics here. */
      v_src0[0] = src->data[index];
      v_src0[1] = src->data[index + 1];
      v_src1[0] = src->data[index + src->width];
      v_src1[1] = src->data[index + src->width + 1];

      // Vector load with constant
      //v_weight0[0] = xfrac;
      //v_weight0[1] = xfrac;
      v_weight0 = vld1_dup_s32(&xfrac);
      //v_weight1[0] = xfrac;
      //v_weight1[1] = xfrac;
      v_weight1 = vld1_dup_s32(&xfrac);

      // Vector multiply
      //v_weight0[0] = v_weight0[0] * v_const0[0];
      //v_weight0[1] = v_weight0[1] * v_const0[1];
      v_weight0 = vmul_s32(v_weight0, v_const0);
      //v_weight1[0] = v_weight1[0] * v_const0[0];
      //v_weight1[1] = v_weight1[1] * v_const0[1];
      v_weight1 = vmul_s32(v_weight1, v_const0);

      // Vector substract
      //v_weight0[0] = v_const1[0] - v_weight0[0];
      //v_weight0[1] = v_const1[1] - v_weight0[1];
      v_weight0 = vsub_s32(v_const1, v_weight0);
      //v_weight1[0] = v_const1[0] - v_weight1[0];
      //v_weight1[1] = v_const1[1] - v_weight1[1];
      v_weight1 = vsub_s32(v_const1, v_weight1);

      // Vector multiply
      //v_weight0[0] = v_weight0[0] * i_yfrac;
      //v_weight0[1] = v_weight0[1] * i_yfrac;
      v_weight0 = vmul_n_s32(v_weight0, i_yfrac);
      //v_weight1[0] = v_weight1[0] * yfrac;
      //v_weight1[1] = v_weight1[1] * yfrac;
      v_weight1 = vmul_n_s32(v_weight1, yfrac);

      // Vector multiply
      //v_src0[0] = v_src0[0] * v_weight0[0];
      //v_src0[1] = v_src0[1] * v_weight0[1];
      v_src0 = vmul_s32(v_src0, v_weight0);
      //v_src1[0] = v_src1[0] * v_weight1[0];
      //v_src1[1] = v_src1[1] * v_weight1[1];
      v_src1 = vmul_s32(v_src1, v_weight1);

      // Vector accross vector
      // gray = v_src0[0] + v_src1[0] +
      //      + v_src0[1] + v_src1[1];
      /* Note that on armv8 NEON has been extended with vaddv instruction
         which sums up all vector lanes and returs scalar value. This
         would perfectly fit here. */
      v_src0 = vadd_s32(v_src0, v_src1);
      gray = vget_lane_s32(v_src0, 0) +
             +vget_lane_s32(v_src0, 1);

      gray >>= (Q_BITS + Q_BITS);

      dst->data[k++] = (uint32_t)gray;
    }
  }
}
#endif

int main(int argc, char **argv)
{
  if (argc != 4)
  {
    printf("Usage: ./scale input.simple output.simple 0.5\n");
    return EXIT_FAILURE;
  }
  char *src_file = argv[1];
  char *dst_file = argv[2];
  float scale_factor = atof(argv[3]);

  SIMPLE_Image *src = SIMPLE_open(src_file);
  if (src == NULL)
  {
    return EXIT_FAILURE;
  }
  SIMPLE_Image *dst = SIMPLE_new(
      src->width * scale_factor,
      src->height * scale_factor);

  scale(src, dst, scale_factor);

  int status = SIMPLE_save(dst, dst_file);
  SIMPLE_destroy(src);
  SIMPLE_destroy(dst);
  return status;
}
