#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "bin.h"

uint8_t getpixel(BIN_Image* img, unsigned int x, unsigned int y) {
  int pxl = ((y * img->width) + x);
  return img->data[pxl];
}

void putpixel(BIN_Image* img, unsigned int x, unsigned int y, uint8_t color) {
  int pxl = ((y * img->width) + x);
  img->data[pxl] = color;
}

float lerp(float s, float e, float t) {
  return s + (e - s) * t;
}

float blerp(float c00, float c10, float c01, float c11, float tx, float ty) {
  return lerp(lerp(c00, c10, tx), lerp(c01, c11, tx), ty);
}

void scale(BIN_Image* src, BIN_Image* dst, float scalex, float scaley) {
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
    printf("Usage: ./scale input.bin output.bin 0.5\n");
    return EXIT_FAILURE;
  }
  char* src_file = argv[1];
  char* dst_file = argv[2];
  float scale_factor = atof(argv[3]);

  BIN_Image* src = NULL;
  FILE* src_fptr = NULL;
  src_fptr = fopen(src_file, "w");
  if (src_fptr == NULL) {
    return EXIT_FAILURE;
  }
  int status = EXIT_SUCCESS;
  int data_size;
  src = malloc(sizeof(BIN_Image));
  if (
      fread(&(src->width), sizeof(uint32_t), 1, src_fptr) != 1 ||
      fread(&(src->height), sizeof(uint32_t), 1, src_fptr) != 1) {
    status = EXIT_FAILURE;
    goto cleanup;
  }
  data_size = src->width * src->height;
  src->data = malloc(data_size);
  if (fread(src->data, sizeof(uint8_t), data_size, src_fptr) != data_size) {
    status = EXIT_FAILURE;
    goto cleanup;
  }

  BIN_Image* dst = malloc(sizeof(BIN_Image));
  dst->width = src->width / 2;
  dst->height = src->height / 2;
  dst->data = malloc(dst->width * dst->height);

  printf("Scaling\n");
  scale(src, dst, scale_factor, scale_factor);
  printf("Done\n");

  // This is copied in conv_bpm_bin.c. Didn't want to make a bin.c shared file
  FILE* dst_fptr = NULL;
  dst_fptr = fopen(dst_file, "w");
  if (dst_fptr == NULL) {
    status = EXIT_FAILURE;
    goto cleanup;
  }
  if (
      fwrite(&(dst->width), sizeof(uint32_t), 1, dst_fptr) != 1 ||
      fwrite(&(dst->height), sizeof(uint32_t), 1, dst_fptr) != 1) {
    status = EXIT_FAILURE;
    goto cleanup;
  }
  data_size = dst->width * dst->height;
  if (fwrite(dst->data, sizeof(uint8_t), data_size, dst_fptr) != data_size) {
    printf("Failed writing output data\n");
    status = EXIT_FAILURE;
    goto cleanup;
  }
cleanup:
  if (src_fptr != NULL) {
    fclose(src_fptr);
  }
  if (dst_fptr != NULL) {
    fclose(dst_fptr);
  }
  free(src->data);
  free(src);
  free(dst->data);
  free(dst);
  return status;
}
