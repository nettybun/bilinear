#ifndef _SIMPLE_H_
#define _SIMPLE_H_
#include <stdint.h>

#pragma pack(1)

typedef struct {
  uint32_t width;
  uint32_t height;
  uint8_t* data;
} SIMPLE_Image;

SIMPLE_Image* SIMPLE_open(const char* filename);

SIMPLE_Image* SIMPLE_new(unsigned int width, unsigned int height);

int SIMPLE_save(const SIMPLE_Image* image, const char* filename);

void SIMPLE_destroy(SIMPLE_Image* image);

#endif
