// LZW streaming compressor based on LZW AB.
// Copyright (c) 2016 David Bryant, 2018+ other authors, all rights reserved (see AUTHORS).
// Distributed under the BSD Software License (see LICENSE).

#if !defined(LZWS_COMPRESSOR_DICTIONARY_LINKED_LIST_MAIN_H)
#define LZWS_COMPRESSOR_DICTIONARY_LINKED_LIST_MAIN_H

#include "type.h"

#undef LZWS_INLINE
#if defined(LZWS_COMPRESSOR_DICTIONARY_LINKED_LIST_MAIN_C)
#define LZWS_INLINE
#else
#define LZWS_INLINE inline
#endif

LZWS_INLINE void lzws_compressor_initialize_dictionary(lzws_compressor_dictionary_t* dictionary_ptr, lzws_code_fast_t initial_used_code) {
  // We won't store char codes and clear code.
  dictionary_ptr->codes_length_offset = initial_used_code + 1;

  dictionary_ptr->first_child_codes    = NULL;
  dictionary_ptr->next_sibling_codes   = NULL;
  dictionary_ptr->last_symbol_by_codes = NULL;
}

lzws_result_t    lzws_compressor_allocate_dictionary(lzws_compressor_dictionary_t* dictionary_ptr, uint_fast8_t max_code_bits);
void             lzws_compressor_clear_dictionary(lzws_compressor_dictionary_t* dictionary_ptr, uint_fast8_t max_code_bits);
lzws_code_fast_t lzws_compressor_get_next_code_from_dictionary(lzws_compressor_dictionary_t* dictionary_ptr, lzws_code_fast_t current_code, uint_fast8_t next_symbol);
void             lzws_compressor_save_next_code_to_dictionary(lzws_compressor_dictionary_t* dictionary_ptr, lzws_code_fast_t current_code, uint_fast8_t next_symbol, lzws_code_fast_t next_code);

LZWS_INLINE void lzws_compressor_free_dictionary(lzws_compressor_dictionary_t* dictionary_ptr) {
  if (dictionary_ptr->first_child_codes != NULL) {
    free(dictionary_ptr->first_child_codes);
  }

  if (dictionary_ptr->next_sibling_codes != NULL) {
    free(dictionary_ptr->next_sibling_codes);
  }

  if (dictionary_ptr->last_symbol_by_codes != NULL) {
    free(dictionary_ptr->last_symbol_by_codes);
  }
}

#endif // LZWS_COMPRESSOR_DICTIONARY_LINKED_LIST_MAIN_H
