// Converts a BMP into the simple binary format we need

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bmp.h"
#include "simple.h"

int main(int argc, char** argv) {
  if (argc != 2) {
    printf("Usage: ./bmp_to_simple_convert input.bmp; open ./input.simple\n");
    return EXIT_FAILURE;
  }
  char* filename = argv[1];
  BMP_Image* bmp = BMP_open(filename);
  if (bmp == NULL) {
    return EXIT_FAILURE;
  }
  uint32_t w = (bmp->header).width;
  uint32_t h = (bmp->header).height;

  SIMPLE_Image* simple = SIMPLE_new(w, h);
  int pixels = w * h;
  int pxl;

  // Grayscale conversion
  for (pxl = 0; pxl < pixels; pxl++) {
    uint8_t b = bmp->data[(3 * pxl)];
    uint8_t g = bmp->data[(3 * pxl) + 1];
    uint8_t r = bmp->data[(3 * pxl) + 2];
    double gray = 0.2989 * r + 0.5870 * g + 0.1140 * b;
    simple->data[pxl] = gray;
  }

  int status = SIMPLE_save(simple, filename);
  BMP_destroy(bmp);
  SIMPLE_destroy(simple);
  return status;
}
