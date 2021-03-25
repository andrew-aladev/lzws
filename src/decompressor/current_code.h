// LZW streaming decompressor based on LZW AB.
// Copyright (c) 2016 David Bryant, 2018+ other authors, all rights reserved (see AUTHORS).
// Distributed under the BSD Software License (see LICENSE).

#if !defined(LZWS_DECOMPRESSOR_PROCESS_CODE_H)
#define LZWS_DECOMPRESSOR_PROCESS_CODE_H

#include "state.h"

#if defined(__cplusplus)
extern "C" {
#endif

LZWS_EXPORT lzws_result_t lzws_decompressor_read_first_code(
  lzws_decompressor_state_t* state_ptr,
  lzws_byte_t**              source_ptr,
  size_t*                    source_length_ptr);

LZWS_EXPORT lzws_result_t lzws_decompressor_read_next_code(
  lzws_decompressor_state_t* state_ptr,
  lzws_byte_t**              source_ptr,
  size_t*                    source_length_ptr);

#if defined(__cplusplus)
} // extern "C"
#endif

#endif // LZWS_DECOMPRESSOR_PROCESS_CODE_H
