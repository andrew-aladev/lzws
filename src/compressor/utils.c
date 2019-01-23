// LZW streaming compressor based on LZW AB.
// Copyright (c) 2016 David Bryant, 2018+ other authors, all rights reserved (see AUTHORS).
// Distributed under the BSD Software License (see LICENSE).

#include "ratio/main.h"

#include "../utils.h"

#include "utils.h"

void lzws_compressor_read_byte(lzws_compressor_state_t* state_ptr, uint8_t** source_ptr, size_t* source_length_ptr, uint_fast8_t* byte_ptr) {
  lzws_read_byte(source_ptr, source_length_ptr, byte_ptr);
  lzws_compressor_add_source_symbol_to_ratio(state_ptr);
}

void lzws_compressor_write_byte(lzws_compressor_state_t* state_ptr, uint8_t** destination_ptr, size_t* destination_length_ptr, uint_fast8_t byte) {
  if (state_ptr->msb) {
    byte = lzws_reverse_byte(byte);
  }

  lzws_write_byte(destination_ptr, destination_length_ptr, byte);
  lzws_compressor_add_destination_symbol_to_ratio(state_ptr);
}
