// Convert bin to BMP to visualize

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bin.h"
#include "bmp.h"

int main(int argc, char** argv) {
  if (argc != 2) {
    printf("Usage: ./conv_bin_bmp input.bin; open ./input.bin.bmp\n");
    return EXIT_FAILURE;
  }
  FILE* fptr = NULL;
  BIN_Image* bin = NULL;
  fptr = fopen(argv[1], "r");  // "rb" unnecessary in Linux
  if (fptr == NULL) {
    return EXIT_FAILURE;
  }
  bin = malloc(sizeof(BIN_Image));
  if (
      fread(&(bin->width), sizeof(uint32_t), 1, fptr) != 1 ||
      fread(&(bin->height), sizeof(uint32_t), 1, fptr) != 1) {
    fclose(fptr);
    return EXIT_FAILURE;
  }
  int data_size = bin->width * bin->height;
  bin->data = malloc(data_size);
  if (fread(bin->data, sizeof(uint8_t), data_size, fptr) != data_size) {
    fclose(fptr);
    return EXIT_FAILURE;
  }

  BMP_Image* bmp = BMP_new(bin->width, bin->height);
  for (int pxl = 0; pxl < data_size; pxl += 3) {
    bmp->data[pxl] = bin->data[pxl / 3];
    bmp->data[pxl + 1] = bin->data[pxl / 3];
    bmp->data[pxl + 2] = bin->data[pxl / 3];
  }
  char* filename;
  filename = malloc(strlen(argv[1]) + 5);
  strcpy(filename, argv[1]);
  strcat(filename, ".bmp");
  if (BMP_save(bmp, filename) == 0) {
    printf("Failed writing BMP\n");
    BMP_destroy(bmp);
    free(bin->data);
    free(bin);
    return EXIT_FAILURE;
  }
  BMP_destroy(bmp);
  free(bin->data);
  free(bin);
  return EXIT_SUCCESS;
}
