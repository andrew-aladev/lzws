#!/bin/sh
set -e

cd "$(dirname $0)"

tmp="../tmp"
build="$tmp/toolchain-build"

mkdir -p "$build"
cd "$build"

# We need to tests builds for all possible toolchains and dictionaries.
toolchains="../../cmake/toolchains"

kernel_name=$(uname -s)
if [ $kernel_name = "Darwin" ]; then
  toolchains="$toolchains/osx"
elif [ $kernel_name = "FreeBSD" ]; then
  toolchains="$toolchains/freebsd"
else
  toolchains="$toolchains/linux"
fi

find "$toolchains" -type f | while read -r toolchain; do
  for dictionary in "linked-list" "sparse-array"; do
    echo "toolchain: $toolchain, dictionary: $dictionary"

    find . \( -name "CMake*" -o -name "*.cmake" \) -exec rm -rf {} +

    cmake "../.." \
      -DCMAKE_TOOLCHAIN_FILE="$toolchain" \
      -DLZWS_COMPRESSOR_DICTIONARY="$dictionary" \
      -DLZWS_SHARED=ON \
      -DLZWS_STATIC=ON \
      -DLZWS_CLI=OFF \
      -DLZWS_TESTS=ON \
      -DLZWS_EXAMPLES=ON \
      -DLZWS_MAN=OFF \
      -DCMAKE_BUILD_TYPE="RELEASE" \
      -DCMAKE_C_FLAGS_RELEASE="-O2 -march=native"
    make clean
    make -j2

    CTEST_OUTPUT_ON_FAILURE=1 make test
  done
done
