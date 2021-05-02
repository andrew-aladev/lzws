set (CPACK_PACKAGE_NAME ${PROJECT_NAME})
set (CPACK_PACKAGE_DESCRIPTION_SUMMARY "LZW streaming compressor/decompressor")
set (CPACK_PACKAGE_VERSION ${LZWS_VERSION})
set (CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE")
set (CPACK_RESOURCE_FILE_README  "${PROJECT_SOURCE_DIR}/README.md")

set (CPACK_GENERATOR "TGZ" "ZIP")

if (CMAKE_SYSTEM_NAME MATCHES "Linux")
  set (CPACK_GENERATOR ${CPACK_GENERATOR} "DEB" "RPM")
elseif (CMAKE_SYSTEM_NAME MATCHES "Darwin")
  set (CPACK_GENERATOR ${CPACK_GENERATOR} "DragNDrop")
elseif (CMAKE_SYSTEM_NAME MATCHES "FreeBSD")
  set (CPACK_GENERATOR ${CPACK_GENERATOR} "FREEBSD")
elseif (CMAKE_SYSTEM_NAME MATCHES "Windows")
  set (CPACK_GENERATOR ${CPACK_GENERATOR} "NSIS")
endif ()

if (DEFINED CMAKE_SYSTEM_PROCESSOR AND NOT CMAKE_SYSTEM_PROCESSOR STREQUAL "")
  string (TOLOWER ${CMAKE_SYSTEM_PROCESSOR} CPACK_DEBIAN_PACKAGE_ARCHITECTURE)
else ()
  set (CPACK_DEBIAN_PACKAGE_ARCHITECTURE "amd64")
endif ()

set (CPACK_DEBIAN_PACKAGE_MAINTAINER "Andrew Aladjev <aladjev.andrew@gmail.com>")

if (LZWS_BIGNUM_LIBRARY STREQUAL "gmp")
  set (CPACK_DEBIAN_PACKAGE_DEPENDS "libgmp-dev")
  set (CPACK_RPM_PACKAGE_REQUIRES "gmp-devel")
  set (CPACK_FREEBSD_PACKAGE_DEPS "math/gmp")
elseif (LZWS_BIGNUM_LIBRARY STREQUAL "tommath")
  set (CPACK_DEBIAN_PACKAGE_DEPENDS "libtommath-dev")
  set (CPACK_RPM_PACKAGE_REQUIRES "libtommath-devel")
  set (CPACK_FREEBSD_PACKAGE_DEPS "math/libtommath")
else ()
  message (FATAL_ERROR "Invalid bignum library: ${LZWS_BIGNUM_LIBRARY}")
endif ()

set (
  PACKAGE_NAME
  "${CPACK_PACKAGE_NAME}-${LZWS_COMPRESSOR_DICTIONARY}-${LZWS_BIGNUM_LIBRARY}"
)
set (
  CPACK_PACKAGE_FILE_NAME
  "${PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}.${CPACK_DEBIAN_PACKAGE_ARCHITECTURE}"
)
set (CPACK_STRIP_FILES true)
