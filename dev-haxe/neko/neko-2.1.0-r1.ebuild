# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="The Neko Virtual Machine"
HOMEPAGE="http://nekovm.org/"
SRC_URI="https://github.com/HaxeFoundation/neko/archive/v2-1-0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/neko-2-1-0"
BUILD_DIR="${S}/build"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/boehm-gc
    sys-libs/zlib
    dev-libs/libpcre
    www-servers/apache
    dev-libs/apr
    virtual/libmysqlclient
    dev-db/sqlite
    dev-libs/openssl
    net-libs/mbedtls
    x11-libs/gtk+:2
"
RDEPEND="${DEPEND}"

src_prepare() {
    # There is probably a cleaner way to do that
    sed -i \
        -e "s/set(DEST_LIB lib)/set(DEST_LIB $(get_libdir))/" \
        -e "s/set(DEST_NDLL lib\/neko)/set(DEST_NDLL $(get_libdir)\/neko)/" \
        ${S}/CMakeLists.txt

    cmake-utils_src_prepare
    eapply_user
}

src_configure() {
    local mycmakeargs=(
        "-DRUN_LDCONFIG=OFF"
    )
    cmake-utils_src_configure
}

src_compile() {
    cmake-utils_src_compile
}

src_install() {
    cmake-utils_src_install
}
