// Converts a BMP into the simple binary format we need

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bin.h"
#include "bmp.h"

int main(int argc, char** argv) {
  if (argc != 2) {
    printf("Usage: ./conv_bmp_bin input.bmp; open ./input.bmp.bin\n");
    return EXIT_FAILURE;
  }
  BMP_Image* bmp = BMP_open(argv[1]);
  if (bmp == NULL) {
    return EXIT_FAILURE;
  }
  uint32_t w = (bmp->header).width;
  uint32_t h = (bmp->header).height;

  BIN_Image* bin = malloc(sizeof(BIN_Image));
  bin->width = w;
  bin->height = h;
  bin->data = malloc(w * h);
  for (int pxl = 0; pxl < bmp->data_size; pxl += 3) {
    uint8_t blue = bmp->data[pxl];
    uint8_t green = bmp->data[pxl + 1];
    uint8_t red = bmp->data[pxl + 2];
    double gray = 0.2989 * red + 0.5870 * green + 0.1140 * blue;
    bin->data[pxl / 3] = gray;
  }

  char* filename;
  filename = malloc(strlen(argv[1]) + 5);
  strcpy(filename, argv[1]);
  strcat(filename, ".bin");
  FILE* fptr = NULL;
  fptr = fopen(filename, "w");
  if (fptr == NULL) {
    return EXIT_FAILURE;
  }
  int status = EXIT_SUCCESS;
  if (
      fwrite(&(bin->width), sizeof(uint32_t), 1, fptr) != 1 ||
      fwrite(&(bin->height), sizeof(uint32_t), 1, fptr) != 1) {
    status = EXIT_FAILURE;
    goto cleanup;
  }
  int data_size = bin->width * bin->height;
  if (fwrite(bin->data, sizeof(uint8_t), data_size, fptr) != data_size) {
    printf("Failed writing BIN\n");
    status = EXIT_FAILURE;
    goto cleanup;
  }
cleanup:
  fclose(fptr);
  BMP_destroy(bmp);
  free(bin->data);
  free(bin);
  return status;
}
