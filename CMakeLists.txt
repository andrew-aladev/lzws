cmake_minimum_required (VERSION 3.13)
project ("lzws" "C")

if (PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message (FATAL_ERROR "In-source builds are not allowed")
endif ()

set (CMAKE_PROJECT_DESCRIPTION "LZW streaming compressor/decompressor")
set (CMAKE_PROJECT_HOMEPAGE_URL "https://github.com/andrew-aladev/lzws")
set (LZWS_VERSION "1.5.3")

if (NOT DEFINED CMAKE_INSTALL_LIBDIR)
  set (
    CMAKE_INSTALL_LIBDIR "lib"
    CACHE PATH "output directory for libraries"
  )
endif ()

if (NOT DEFINED CMAKE_INSTALL_INCLUDEDIR)
  set (
    CMAKE_INSTALL_INCLUDEDIR "include"
    CACHE PATH "output directory for include files"
  )
endif ()

if (NOT DEFINED CMAKE_INSTALL_BINDIR)
  set (
    CMAKE_INSTALL_BINDIR "bin"
    CACHE PATH "output directory for binaries"
  )
endif ()

if (NOT DEFINED CMAKE_INSTALL_MANDIR)
  set (
    CMAKE_INSTALL_MANDIR "share/man"
    CACHE PATH "Output directory for man files"
  )
endif ()

# Common output directory is required for OS without rpath support.
set (CMAKE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/result")
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_OUTPUT_DIRECTORY})
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_OUTPUT_DIRECTORY})
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_OUTPUT_DIRECTORY})

if (NOT DEFINED LZWS_TARGET)
  set (LZWS_TARGET ${PROJECT_NAME})
endif ()

string (TOUPPER ${LZWS_TARGET} LZWS_TARGET_UPPERCASE)

set (
  LZWS_COMPRESSOR_DICTIONARY "sparse-array"
  CACHE STRING "dictionary implementation"
)
set (
  LZWS_BIGNUM_LIBRARY ""
  CACHE STRING "bignum library"
)

option (LZWS_SHARED   "build shared binaries" ON)
option (LZWS_STATIC   "build static binaries" OFF)
option (LZWS_CLI      "build cli"             ON)
option (LZWS_TESTS    "build tests"           ON)
option (LZWS_EXAMPLES "build examples"        OFF)
option (LZWS_MAN      "build man"             OFF)
option (LZWS_COVERAGE "enable coverage"       OFF)

set (LZWS_ARGTABLE3_FALLBACK "github-archive" CACHE STRING "argtable3 fallback")

if (NOT LZWS_COMPRESSOR_DICTIONARY)
  message (FATAL_ERROR "Please select dictionary implementation.")
endif ()

if (NOT LZWS_SHARED AND NOT LZWS_STATIC)
  message (FATAL_ERROR "Please enable building of shared or static binaries.")
endif ()

set (
  CMAKE_MODULE_PATH
  "${PROJECT_SOURCE_DIR}/cmake/checks"
  "${PROJECT_SOURCE_DIR}/cmake/finds"
  "${PROJECT_SOURCE_DIR}/cmake/functions"
  "${PROJECT_SOURCE_DIR}/cmake/generators"
)

include (GetVerboseFlags)
cmake_get_verbose_flags ()

include (GetBuildFlags)
cmake_get_build_flags ()

if (LZWS_COVERAGE)
  include (GetCoverageFlags)
  cmake_get_coverage_flags ()
endif ()

include (CheckC11AndAbove)
cmake_check_c11_and_above (REQUIRED)

include (GetExportMode)
cmake_get_export_mode (REQUIRED)

include (CheckIPO)
cmake_check_ipo ()

include (CheckBignumLibrary)
cmake_check_bignum_library ("${LZWS_BIGNUM_LIBRARY}")

# Bignum library selection may be updated.
set (LZWS_BIGNUM_LIBRARY ${CMAKE_BIGNUM_LIBRARY})

set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_VERBOSE_C_FLAGS} ${CMAKE_PIPE_C_FLAGS} ${CMAKE_C11_AND_ABOVE_C_FLAGS}")

if (LZWS_COVERAGE)
  set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_COVERAGE_C_FLAGS}")
endif ()

set (CMAKE_SHARED_LIBRARY_LD_FLAGS ${CMAKE_EXPORT_SHARED_LIBRARY_LD_FLAGS})
set (CMAKE_EXECUTABLE_LD_FLAGS ${CMAKE_EXPORT_EXECUTABLE_LD_FLAGS})

if (NOT DEFINED CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
  set (CMAKE_BUILD_TYPE "Debug")
endif ()

if (LZWS_SHARED AND NOT CMAKE_BIGNUM_LIBRARY_SHARED_PATH)
  message (FATAL_ERROR "Bignum shared library is not available.")
endif ()

if (LZWS_STATIC AND NOT CMAKE_BIGNUM_LIBRARY_STATIC_PATH)
  message (FATAL_ERROR "Bignum static library is not available.")
endif ()

if (LZWS_TESTS)
  enable_testing ()
endif ()

add_subdirectory ("src")

if (LZWS_MAN)
  add_subdirectory ("man")
endif ()

include (CPackConfig.cmake)
include (CPack)
