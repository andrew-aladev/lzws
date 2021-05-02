#!/usr/bin/env bash
set -e

DIR=$(dirname "${BASH_SOURCE[0]}")
source "${DIR}/../env.sh"

FROM_IMAGE="docker.io/${DOCKER_USERNAME}/test_${TARGET}_toolchain"
IMAGE_NAME="${IMAGE_PREFIX}_${TARGET}_toolchain"
IMAGE_PLATFORM="linux/x86"
