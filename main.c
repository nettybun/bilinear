#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "bmp.h"

// n as 0 gets the LAST (RIGHTMOST) byte. n as 3 is the FIRST (LEFTMOST) byte.
#define getByte(value, n) (value >> (n * 8) & 0xFF)

uint32_t getpixel(BMP_Image* img, unsigned int x, unsigned int y) {
  uint8_t* d = img->data;
  int pxl = ((y * img->width) + x) * 3;
  uint32_t pixel = d[pxl] << 24 | d[pxl + 1] << 16 | d[pxl + 2] << 8 | 0;
  return pixel;
}

void putpixel(BMP_Image* img, unsigned int x, unsigned int y, uint32_t color) {
  int pxl = ((y * img->width) + x) * 3;
  img->data[pxl] = getByte(color, 3);
  img->data[pxl + 1] = getByte(color, 2);
  img->data[pxl + 2] = getByte(color, 1);
}

// float lerp(float s, float e, float t) {
//   return s + (e - s) * t;
// }

// float blerp(float c00, float c10, float c01, float c11, float tx, float ty) {
//   return lerp(lerp(c00, c10, tx), lerp(c01, c11, tx), ty);
// }

// void scale(image_t* src, image_t* dst, float scalex, float scaley) {
//   int newWidth = (int)src->w * scalex;
//   int newHeight = (int)src->h * scaley;
//   int x, y;
//   for (x = 0, y = 0; y < newHeight; x++) {
//     if (x > newWidth) {
//       x = 0;
//       y++;
//     }
//     float gx = x / (float)(newWidth) * (src->w - 1);
//     float gy = y / (float)(newHeight) * (src->h - 1);
//     int gxi = (int)gx;
//     int gyi = (int)gy;
//     uint32_t result = 0;
//     uint32_t c00 = getpixel(src, gxi, gyi);
//     uint32_t c10 = getpixel(src, gxi + 1, gyi);
//     uint32_t c01 = getpixel(src, gxi, gyi + 1);
//     uint32_t c11 = getpixel(src, gxi + 1, gyi + 1);
//     uint8_t i;
//     for (i = 0; i < 3; i++) {
//       result |=
//           (uint8_t)blerp(getByte(c00, i), getByte(c10, i), getByte(c01, i),
//                          getByte(c11, i), gx - gxi, gy - gyi)
//           << (8 * i);
//     }
//     putpixel(dst, x, y, result);
//   }
// }

// Grayscale conversion (Still BGR code format (not a typo of RGB))

static uint32_t RGB2Gray(uint32_t pixel) {
  uint8_t blue = getByte(pixel, 3);
  uint8_t green = getByte(pixel, 2);
  uint8_t red = getByte(pixel, 1);
  // this is a commonly used formula
  double gray = 0.2989 * red + 0.5870 * green + 0.1140 * blue;
  // uint32_t gray_pixel = blue << 24 | green << 16 | red << 8 | 0;
  uint32_t gray_pixel = (int)gray << 24 | (int)gray << 16 | (int)gray << 8 | 0;
  return gray_pixel;
}

void BMP_gray(BMP_Image* img) {
  int x, y;
  for (x = 0, y = 0; y < img->height; x++) {
    if (x > img->width) {
      x = 0;
      y++;
    }
    uint32_t pixel = getpixel(img, x, y);
    uint32_t gray = RGB2Gray(pixel);
    putpixel(img, x, y, gray);
  }
}

int main(int argc, char** argv) {
  // Check arguments
  if (argc < 3) {
    printf("Usage: bmp.o <input> <output>\n");
    return EXIT_FAILURE;
  }

  // open the input file
  BMP_Image* img = BMP_open(argv[1]);
  if (img == NULL) {
    return EXIT_FAILURE;
  }

  // We'll change this out for our interpolation method later
  BMP_gray(img);

  if (BMP_save(img, argv[2]) == 0) {
    printf("Failed writing\n");
    BMP_destroy(img);
    return EXIT_FAILURE;
  }
  BMP_destroy(img);
  return EXIT_SUCCESS;
}
