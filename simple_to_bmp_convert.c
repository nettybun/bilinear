// Convert bin to BMP to visualize

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bmp.h"
#include "simple.h"

int main(int argc, char** argv) {
  if (argc != 2) {
    printf("Usage: ./simple_to_bmp_convert input.simple; open ./input.bmp\n");
    return EXIT_FAILURE;
  }
  char* filename = argv[1];
  SIMPLE_Image* simple = SIMPLE_open(filename);
  if (simple == NULL) {
    return EXIT_FAILURE;
  }

  BMP_Image* bmp = BMP_new(simple->width, simple->height);
  int pixels = simple->width * simple->height;
  int pxl;

  for (pxl = 0; pxl < pixels; pxl++) {
    bmp->data[(3 * pxl)] = simple->data[pxl];
    bmp->data[(3 * pxl) + 1] = simple->data[pxl];
    bmp->data[(3 * pxl) + 2] = simple->data[pxl];
  }

  int status = BMP_save(bmp, filename);
  BMP_destroy(bmp);
  SIMPLE_destroy(simple);
  return status;
}
