#include "bmp.h"

#include <stdio.h>
#include <stdlib.h>

// correct values for the header
#define MAGIC_VALUE 0X4D42
// one pixel is a uint32_t so the last 8bits are empty (untrusted)
#define BITS_PER_PIXEL 24
#define NUM_PLANE 1
#define COMPRESSION 0
#define BITS_PER_BYTE 8

// return 0 if the header is invalid
// return 1 if the header is valid
static int checkHeader(BMP_Header* hdr) {
  if ((hdr->type) != MAGIC_VALUE) {
    return 0;
  }
  if ((hdr->bits) != BITS_PER_PIXEL) {
    return 0;
  }
  if ((hdr->planes) != NUM_PLANE) {
    return 0;
  }
  if ((hdr->compression) != COMPRESSION) {
    return 0;
  }
  return 1;
}

// close opened file and release memory
BMP_Image* cleanUp(FILE* fptr, BMP_Image* img) {
  if (fptr != NULL) {
    fclose(fptr);
  }
  free(img->pixels);
  free(img);
  return NULL;
}

BMP_Image* BMP_open(const char* filename) {
  FILE* fptr = NULL;
  BMP_Image* img = NULL;
  fptr = fopen(filename, "r");  // "rb" unnecessary in Linux
  if (fptr == NULL) {
    return cleanUp(fptr, img);
  }
  img = malloc(sizeof(BMP_Image));
  if (img == NULL) {
    return cleanUp(fptr, img);
  }
  // read the header
  if (fread(&(img->header), sizeof(BMP_Header), 1, fptr) != 1) {
    return cleanUp(fptr, img);
  }
  if (checkHeader(&(img->header)) == 0) {
    return cleanUp(fptr, img);
  }
  // TODO: diagrams show padding bytes for BMP? numbers are wrong...
  int bytes_per_pixel = (img->header).bits / BITS_PER_BYTE;
  int data_bytes = ((img->header).size - sizeof(BMP_Header)) / bytes_per_pixel;
  printf("Bytes per pixel: %d\n", bytes_per_pixel);
  printf("Bytes of data after header: %d\n", data_bytes);
  img->width = (img->header).width;
  img->height = (img->header).height;
  img->number_pixels = img->width * img->height;
  img->pixels = malloc(sizeof(uint8_t) * bytes_per_pixel * img->number_pixels);
  printf("Resolution: %d x %d = %d\n", img->width, img->height, img->number_pixels);
  if ((img->pixels) == NULL) {
    return cleanUp(fptr, img);
  }
  int n;
  n = fread(img->pixels, sizeof(uint8_t) * bytes_per_pixel, img->number_pixels, fptr);
  if (n != (img->number_pixels)) {
    printf("Failed loading pixels. Read %d instead of %d\n", n, img->number_pixels);
    return cleanUp(fptr, img);
  }
  // this doesn't need to use uint32_t since it's just a safety check
  char onebyte;
  if (fread(&onebyte, sizeof(char), 1, fptr) != 0) {
    printf("Warning: Failed safety check. Not at end of file after reading pixels\n");
    // file still has pixels so header was wrong
    // continue anyway
    // return cleanUp(fptr, img);
  }
  fclose(fptr);
  return img;
}

int BMP_save(const BMP_Image* img, const char* filename) {
  FILE* fptr = NULL;
  fptr = fopen(filename, "w");
  if (fptr == NULL) {
    return 0;
  }
  // write the header first
  if (fwrite(&(img->header), sizeof(BMP_Header), 1, fptr) != 1) {
    fclose(fptr);
    return 0;
  }
  if (fwrite(img->pixels, sizeof(uint32_t), img->number_pixels, fptr) != (img->number_pixels)) {
    fclose(fptr);
    return 0;
  }
  fclose(fptr);
  return 1;
}

void BMP_destroy(BMP_Image* img) {
  free(img->pixels);
  free(img);
}
