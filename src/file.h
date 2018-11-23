// LZW streaming compressor/decompressor based on LZW AB.
// Copyright (c) 2016 David Bryant, 2018+ other authors, all rights reserved (see AUTHORS).
// Distributed under the BSD Software License (see LICENSE).

#ifndef LZWS_FILE_H_
#define LZWS_FILE_H_

#include <stdio.h>

#include "common.h"
#include "config.h"

// Possible results:
enum {
  LZWS_FILE_ALLOCATE_FAILED = 1,
  LZWS_FILE_COMPRESSOR_FAILED,
  LZWS_FILE_NOT_ENOUGH_DESTINATION_BUFFER,
  LZWS_FILE_WRITE_FAILED
};

#if defined(LZWS_DICTIONARY_TRIE_ON_LINKED_LIST)

// 16 KB for each buffer is enough.
// Performance growth with 32 KB is not significant.
#define DEFAULT_SOURCE_BUFFER_LENGTH (1 << 14)

#elif defined(LZWS_DICTIONARY_TRIE_ON_SPARSE_ARRAY)

// 1 MB for each buffer is enough.
// Performance growth with 2 MB is not significant.
#define DEFAULT_SOURCE_BUFFER_LENGTH (1 << 20)

#endif

#define DEFAULT_DESTINATION_BUFFER_LENGTH DEFAULT_SOURCE_BUFFER_LENGTH

// "source_buffer_length" and "destination_buffer_length" can be equal to 0, it will use default values.
lzws_result_t lzws_file_compress(
    FILE*   source_file,
    size_t  source_buffer_length,
    FILE*   destination_file,
    size_t  destination_buffer_length,
    uint8_t max_code_bits,
    bool    block_mode);

#endif // LZWS_FILE_H_
