# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-multilib cmake-utils git-r3

DESCRIPTION="LZW streaming compressor/decompressor compatible with UNIX compress."
HOMEPAGE="https://github.com/andrew-aladev/lzws"
EGIT_REPO_URI="https://github.com/andrew-aladev/lzws.git"

LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS=""

IUSE="shared-libs static-libs test man"

RDEPEND="
  virtual/libc
  dev-libs/gmp
  man? ( app-text/asciidoc )
"
DEPEND="${RDEPEND}"

src_configure() {
  local mycmakeargs=(
    -DLZWS_SHARED="$(usex shared-libs)
    -DLZWS_STATIC="$(usex static-libs)
    -DLZWS_CLI=1
    -DLZWS_TESTS="$(usex test)
    -DLZWS_EXAMPLES=0
    -DLZWS_MAN="$(usex man)
  )

  cmake-multilib_src_configure
}
