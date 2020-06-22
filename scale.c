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

float lerp(float s, float e, float t) {
  return s + (e - s) * t;
}

float blerp(float c00, float c10, float c01, float c11, float tx, float ty) {
  return lerp(lerp(c00, c10, tx), lerp(c01, c11, tx), ty);
}

void scale(SIMPLE_Image* src, SIMPLE_Image* dst, float scalex, float scaley) {
  int newWidth = (int)src->width * scalex;
  int newHeight = (int)src->height * scaley;
  int x, y;
  for (y = 0; y < dst->height; y++) {
    for (x = 0; x < dst->width; x++) {
      float gx = x / (float)(newWidth) * (src->width - 1);
      float gy = y / (float)(newHeight) * (src->height - 1);
      int gxi = (int)gx;
      int gyi = (int)gy;
      uint8_t c00 = getpixel(src, gxi, gyi);
      uint8_t c10 = getpixel(src, gxi + 1, gyi);
      uint8_t c01 = getpixel(src, gxi, gyi + 1);
      uint8_t c11 = getpixel(src, gxi + 1, gyi + 1);
      uint8_t result = (uint8_t)blerp(c00, c10, c01, c11, gx - gxi, gy - gyi);
      putpixel(dst, x, y, result);
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
  SIMPLE_Image* dst = SIMPLE_new(src->width / 2, src->height / 2);

  printf("Scaling\n");
  scale(src, dst, scale_factor, scale_factor);
  printf("Done\n");

  int status = SIMPLE_save(dst, dst_file);
  SIMPLE_destroy(src);
  SIMPLE_destroy(dst);
  return status;
}
