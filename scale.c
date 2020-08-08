
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "simple.h"

/*
Since S3C440A CPU does not have any SIMD extension, we cannot perform any vectorized implementaion
using NEON. We can only perform such optimization which will reduce numbers of instruction exectured,
replace inefficient instruction with their efficient version or reduce memory usage to decrease cache miss rate.
*/

// #define NAIVE /* simple, easy to understand floatin point implementation from http://www.tech-algorithm.com/articles/bilinear-image-scaling/ */
// #define OPTIMIZED_SCALAR_FLOATING_POINT /* Optimized floating point implementation */
// #define SCALAR_FIXED_POINT /* Implementation with introduced operators that to calculation in fixed point domain. */
#define OPTIMIZED_SCALAR_FIXED_POINT /* Optimized implementation using fixed point calculations */

#ifdef NAIVE
void scale(SIMPLE_Image* src, SIMPLE_Image* dst, float scale_factor)
{
  uint32_t i, j;
  uint32_t k = 0;
  double scale = 1.0f / scale_factor;

  for(i = 0; i < dst->height; i++)
  {
    for(j = 0; j < dst->width; j++)
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

      uint8_t gray = (uint8_t)(A * (1.0f-xfrac) * (1.0f-yfrac) +
                    + B * xfrac * (1.0f-yfrac) +
                    + C * yfrac * (1.0f-xfrac) +
                    + D * xfrac * yfrac);
      dst->data[k++] = gray;
    }
  }
}
#endif
#ifdef OPTIMIZED_SCALAR_FLOATING_POINT
/*
In this implementation few optimizations happened:
- moved y and yfrac calculation to outer loop since it isn't correlated with variable i
- removed double because this CPU has only 32-bit register and to make algorithm faster,
  we must use only native types (such types that fit into CPU registers without any transform)
  because otherwise compiler will add many instruction that must handle 64-bit wide calculations.
- uint8_t type has been also removed from calculations as it also isn't native type for 32-bit architecture.
- for loops replaced by while(). Usually while loops are the fastests especially when condition inside
  them is as simple as possible. That's why I switch to iterating from the end of image.
*/
void scale(SIMPLE_Image* src, SIMPLE_Image* dst, float scale_factor)
{
  uint32_t i = dst->height, k = dst->height*dst->width-1;
  uint32_t j;
  float scale = 1.0f / scale_factor;

  while(i--)
  {
    uint32_t y = (uint32_t)(scale * i);
    float yfrac = scale * i - y;
    j = dst->width;

    while(j--)
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
                    + B * xfrac * i_yfrac +
                    + C * yfrac * i_xfrac +
                    + D * xfrac * yfrac);
      dst->data[k--] = (uint8_t)gray;
    }
  }
}
#endif
#ifdef SCALAR_FIXED_POINT

/*
Since S3C440A does not have a floating-point unit, we should avoid any
floating point calculation since they won't have any hardware acceleration.
Therefore we need to make all calculation on integer values.
In order to perform correctly fractional calculations on integer values,
we implement them using fixed-point calculation. Good and simple explanation
is here:
https://spin.atomicobject.com/2012/03/15/simple-fixed-point-math/

I have introduced new type called tQfract which will hold fractional
value represented by integer value. I also added basic operations on this type.
In order to mix fractional values and non-fractional values, I added conversions
between plain integer and fractional (represented by integer).

Value of Q_BITS must be high enough to maintain proper accuracy during calculation
but low enough to prevent from any overflow during multiplication.
*/

typedef uint32_t tQfract;
#define Q_BITS (16u)
#define Q_MAX ((tQfract)(1<<Q_BITS))
#define Q_FLOAT_TO_FIXED(a) ((tQfract)((float)a*Q_MAX))
#define Q_INT_TO_FRACT(a) ((tQfract)((a)<<Q_BITS))
#define Q_FRACT_TO_INT(a) ((uint32_t)((a)>>Q_BITS))
#define Q_ADD(a,b) ((tQfract)(a)+(b))
#define Q_SUB(a,b) ((tQfract)(a)-(b))
#define Q_MUL(a,b) ((tQfract)(((uint64_t)a)*(b) >> Q_BITS))
#define Q_DOT4(a,b,c,d) ((tQfract)(a)+(b)+(c)+(d))
#define Q_10 Q_MAX

void scale(SIMPLE_Image* src, SIMPLE_Image* dst, float scale_factor)
{
  uint32_t i = dst->height, k = dst->height*dst->width-1;
  uint32_t j;
  // float scale = 1.0f / scale_factor;
  uint32_t scale = Q_FLOAT_TO_FIXED(1.0f / scale_factor);

  while(i--)
  {
    // uint32_t y = (uint32_t)(scale * i);
    uint32_t y = Q_FRACT_TO_INT(Q_MUL(scale, Q_INT_TO_FRACT(i)));
    // float yfrac = scale * i - y;
    tQfract yfrac = Q_SUB(Q_MUL(scale, Q_INT_TO_FRACT(i)), Q_INT_TO_FRACT(y));
    j = dst->width;

    while(j--)
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
      uint32_t gray =  Q_FRACT_TO_INT(
                         Q_DOT4(
                           Q_MUL(Q_INT_TO_FRACT(A), Q_MUL(i_xfrac, i_yfrac))
                         , Q_MUL(Q_INT_TO_FRACT(B), Q_MUL(xfrac, i_yfrac))
                         , Q_MUL(Q_INT_TO_FRACT(C), Q_MUL(yfrac, i_xfrac)) 
                         , Q_MUL(Q_INT_TO_FRACT(D), Q_MUL(xfrac, yfrac))
                         )
                       );
      dst->data[k--] = (uint8_t)gray;
    }
  }
}
#endif
#ifdef OPTIMIZED_SCALAR_FIXED_POINT

/*
This implemation behaves exactly like previous one BUT the main
optimizaton here was to remove unnecessarry shifting by Q_BITS.
One good optimization here was to tune Q_BITS in order to allow
chained multiplication without additional shifting. 
In this algorithm follwing multiplication chain is the longest:
A * i_xfrac * i_yfrac
It is dictating maximum Q_BITS value to allow 3 multiplication in a row without shifting back and forth. 
There are 3 multiplication and the result cannot exceed 32 bits. We know that A,B,C,D will not be higher than 255.
So the biggest number X that will satisfy equation (255 * X * X < 2^32) is 2048.
Therefore 2048 will be our fractional scale. Higher number might produce overflow,
lower number will decreace accuracy.
*/

#define Q_BITS (11u)
#define Q_MAX ((uint32_t)(1<<Q_BITS))
#define Q_FLOAT_TO_FIXED(a) ((uint32_t)((float)a*Q_MAX))
#define Q_10 Q_MAX

void scale(SIMPLE_Image* src, SIMPLE_Image* dst, float scale_factor)
{
  uint32_t i = dst->height, k = dst->height*dst->width-1;
  uint32_t j;
  // float scale = 1.0f / scale_factor;
  uint32_t scale = Q_FLOAT_TO_FIXED(1.0f / scale_factor);

  while(i--)
  {
    // uint32_t y = (uint32_t)(scale * i);
    uint32_t y = (scale * i) >> Q_BITS;
    // float yfrac = scale * i - y;
    uint32_t yfrac = (scale * i) - (y << Q_BITS);
    j = dst->width;

    while(j--)
    {
      // uint32_t x = (uint32_t)(scale * j);
      uint32_t x = (scale * j) >> Q_BITS;
      // float xfrac = scale * j - x;
      uint32_t xfrac = (scale * j) - (x << Q_BITS);

      // float i_xfrac = 1.0f - xfrac;
      uint32_t i_xfrac = Q_10 - xfrac;
      // float i_yfrac = 1.0f - yfrac;
      uint32_t i_yfrac = Q_10 - yfrac;
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
                    + B * xfrac * i_yfrac +
                    + C * yfrac * i_xfrac +
                    + D * xfrac * yfrac) >> (Q_BITS+Q_BITS);
      dst->data[k--] = (uint8_t)gray;
    }
  }
}
#endif


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
