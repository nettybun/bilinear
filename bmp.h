#ifndef _BMP_H_
#define _BMP_H_
#include <stdint.h>

// tell compiler not to add space between the attributes
#pragma pack(1)

// BMP file has two headers; normal header (14 bytes) and DIB header (40 bytes)
// BMP_Header is both headers (54 bytes) and then data is after
typedef struct {
  // Header
  uint16_t type;       // Magic identifier
  uint32_t size;       // File size in bytes
  uint16_t reserved1;  // Not used
  uint16_t reserved2;  // Not used
  uint32_t offset;     // Offset to image data in bytes from beginning of file (54 bytes)

  // DIB header
  uint32_t dib_header_size;   // DIB header size in bytes (40 bytes)
  uint32_t width;             // Width of the image
  uint32_t height;            // Height of image
  uint16_t planes;            // Number of color planes
  uint16_t bits;              // Bits per pixel
  uint32_t compression;       // Compression type
  uint32_t imagesize;         // Compressed image (bytes); 0 if compression = 0
  uint32_t xresolution;       // Pixels per meter
  uint32_t yresolution;       // Pixels per meter
  uint32_t ncolours;          // Number of colors
  uint32_t importantcolours;  // Important colors
} BMP_Header;

typedef struct {
  BMP_Header header;  // 54 bytes
  unsigned int data_size;
  unsigned int width;
  unsigned int height;
  uint8_t* data;
} BMP_Image;

BMP_Image* BMP_open(const char* filename);

BMP_Image* BMP_new(unsigned int width, unsigned int height);

int BMP_save(const BMP_Image* image, const char* filename);

void BMP_destroy(BMP_Image* image);

#endif
