#include "bmp.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// correct values for the header
#define MAGIC_VALUE 0X4D42
#define BITS_PER_PIXEL 24
#define BYTES_PER_PIXEL (BITS_PER_PIXEL / 3)
#define NUM_PLANE 1
#define COMPRESSION 0
#define EXT ".bmp"

char* BMP_replace_ext(const char* filename) {
  char* new_filename = malloc(strlen(filename) + sizeof(EXT));
  strcpy(new_filename, filename);

  char* ptrFile = strrchr(new_filename, '/');
  ptrFile = (ptrFile) ? new_filename : ptrFile + 1;

  char* ptrExt = strrchr(ptrFile, '.');
  if (ptrExt != NULL)
    strcpy(ptrExt, EXT);
  else
    strcat(ptrFile, EXT);
  return new_filename;
}

static int BMP_check_header(BMP_Header* hdr) {
  if (
      (hdr->type) != MAGIC_VALUE ||
      (hdr->bits) != BITS_PER_PIXEL ||
      (hdr->planes) != NUM_PLANE ||
      (hdr->compression) != COMPRESSION) {
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

BMP_Image* BMP_clean_up(FILE* fptr, BMP_Image* img) {
  if (fptr != NULL) {
    fclose(fptr);
  }
  if (img != NULL) {
    free(img->data);
    free(img);
  }
  return NULL;
}

BMP_Image* BMP_open(const char* filename) {
  FILE* fptr = NULL;
  BMP_Image* img = NULL;
  fptr = fopen(filename, "r");  // "rb" unnecessary in Linux
  if (fptr == NULL) {
    printf("ERR: Couldn't open file %s\n", filename);
    return BMP_clean_up(fptr, img);
  }
  img = malloc(sizeof(BMP_Image));
  if (img == NULL) {
    printf("ERR: Couldn't malloc() BMP_Image\n");
    return BMP_clean_up(fptr, img);
  }
  // read the header
  if (fread(&(img->header), sizeof(BMP_Header), 1, fptr) != 1) {
    printf("ERR: Couldn't read BMP header from file\n");
    return BMP_clean_up(fptr, img);
  }
  if (BMP_check_header(&(img->header)) == EXIT_FAILURE) {
    printf("ERR: BMP header isn't valid\n");
    return BMP_clean_up(fptr, img);
  }
  img->data_size = (img->header).size - sizeof(BMP_Header);
  img->width = (img->header).width;
  img->height = (img->header).height;
  img->data = malloc(sizeof(uint8_t) * img->data_size);

  if (fread(img->data, sizeof(uint8_t), img->data_size, fptr) != img->data_size) {
    printf("ERR: Couldn't read BMP image pixel data\n");
    return BMP_clean_up(fptr, img);
  }
  // Sanity check, if supposedly at EOF but there's still data
  uint8_t onebyte;
  if (fread(&onebyte, sizeof(uint8_t), 1, fptr) != 0) {
    printf("ERR: BMP still has data after last known pixel\n");
    return BMP_clean_up(fptr, img);
  }
  fclose(fptr);
  return img;
}

BMP_Image* BMP_new(unsigned int width, unsigned int height) {
  int data_size = width * height * BYTES_PER_PIXEL;
  BMP_Image* img = NULL;
  img = malloc(sizeof(BMP_Image));

  BMP_Header* header = malloc(sizeof(BMP_Header));
  header->type = MAGIC_VALUE;
  header->size = sizeof(BMP_Header) + data_size;
  header->offset = sizeof(BMP_Header);  // 54
  header->dib_header_size = 40;
  header->width = width;
  header->height = height;
  header->planes = NUM_PLANE;
  header->bits = BITS_PER_PIXEL;
  header->compression = COMPRESSION;
  header->imagesize = 0;
  header->xresolution = 0;
  header->yresolution = 0;
  header->ncolours = 0;
  header->importantcolours = 0;

  img->header = *header;
  img->data_size = data_size;
  img->width = width;
  img->height = height;
  img->data = malloc(sizeof(uint8_t) * data_size);
  return img;
}

int BMP_save(const BMP_Image* img, const char* filename) {
  char* new_filename = BMP_replace_ext(filename);
  FILE* fptr = fopen(new_filename, "w");
  if (fptr == NULL) {
    return EXIT_FAILURE;
  }
  if (
      fwrite(&(img->header), sizeof(BMP_Header), 1, fptr) != 1 ||
      fwrite(img->data, sizeof(uint8_t), img->data_size, fptr) != img->data_size) {
    fclose(fptr);
    return EXIT_FAILURE;
  }
  fclose(fptr);
  return EXIT_SUCCESS;
}

void BMP_destroy(BMP_Image* img) {
  free(img->data);
  free(img);
}
