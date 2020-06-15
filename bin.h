#ifndef _BIN_H_
#define _BIN_H_
#include <stdint.h>

#pragma pack(1)

typedef struct {
  uint32_t width;
  uint32_t height;
  uint8_t* data;
} BIN_Image;

#endif
