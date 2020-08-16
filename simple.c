#include "simple.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define EXT ".simple"

char* SIMPLE_replace_ext(const char* filename) {
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

SIMPLE_Image* SIMPLE_clean_up(FILE* fptr, SIMPLE_Image* img) {
  if (fptr != NULL) {
    fclose(fptr);
  }
  if (img != NULL) {
    free(img->data);
    free(img);
  }
  return NULL;
}

SIMPLE_Image* SIMPLE_open(const char* filename) {
  FILE* fptr = NULL;
  SIMPLE_Image* img = NULL;
  fptr = fopen(filename, "r");  // "rb" unnecessary in Linux
  if (fptr == NULL) {
    return SIMPLE_clean_up(fptr, img);
  }
  img = malloc(sizeof(SIMPLE_Image));
  if (
      fread(&(img->width), sizeof(uint32_t), 1, fptr) != 1 ||
      fread(&(img->height), sizeof(uint32_t), 1, fptr) != 1) {
    return SIMPLE_clean_up(fptr, img);
  }
  int data_size = img->width * img->height;
  img->data = malloc(sizeof(uint8_t) * data_size);
  if (fread(img->data, sizeof(uint8_t), data_size, fptr) != data_size) {
    return SIMPLE_clean_up(fptr, img);
  }
  // Sanity check, if supposedly at EOF but there's still data
  uint8_t onebyte;
  if (fread(&onebyte, sizeof(uint8_t), 1, fptr) != 0) {
    return SIMPLE_clean_up(fptr, img);
  }
  fclose(fptr);
  return img;
}

SIMPLE_Image* SIMPLE_new(unsigned int width, unsigned int height) {
  int data_size = width * height;
  SIMPLE_Image* img = NULL;
  img = malloc(sizeof(SIMPLE_Image));
  img->width = width;
  img->height = height;
  img->data = malloc(sizeof(uint8_t) * data_size);
  return img;
}

int SIMPLE_save(const SIMPLE_Image* img, const char* filename) {
  char* new_filename = SIMPLE_replace_ext(filename);
  FILE* fptr = fopen(new_filename, "w");
  if (fptr == NULL) {
    return EXIT_FAILURE;
  }
  int data_size = img->width * img->height;
  if (
      fwrite(&(img->width), sizeof(uint32_t), 1, fptr) != 1 ||
      fwrite(&(img->height), sizeof(uint32_t), 1, fptr) != 1 ||
      fwrite(img->data, sizeof(uint8_t), data_size, fptr) != data_size) {
    fclose(fptr);
    return EXIT_FAILURE;
  }
  fclose(fptr);
  return EXIT_SUCCESS;
}

void SIMPLE_destroy(SIMPLE_Image* img) {
  free(img->data);
  free(img);
}
