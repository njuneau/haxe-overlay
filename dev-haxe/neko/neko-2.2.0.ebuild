# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="The Neko Virtual Machine"
HOMEPAGE="http://nekovm.org/"
SRC_URI="https://github.com/HaxeFoundation/neko/archive/v2-2-0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/neko-2-2-0"
BUILD_DIR="${S}/build"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+regexp apache mysql sqlite ssl gtk +nekoml"

DEPEND="dev-libs/boehm-gc
    sys-libs/zlib
    regexp? (
        dev-libs/libpcre
    )
    apache? (
        www-servers/apache
        dev-libs/apr
    )
    mysql? (
        virtual/libmysqlclient
    )
    sqlite? (
        dev-db/sqlite
    )
    ssl? (
        dev-libs/openssl
        net-libs/mbedtls
    )
    gtk? (
        x11-libs/gtk+:2
    )
"
RDEPEND="${DEPEND}"

#src_prepare() {
#    # There is probably a cleaner way to do that
#    sed -i \
#        -e "s/set(DEST_LIB lib)/set(DEST_LIB $(get_libdir))/" \
#        -e "s/set(DEST_NDLL lib\/neko)/set(DEST_NDLL $(get_libdir)\/neko)/" \
#        ${S}/CMakeLists.txt
#
#    cmake-utils_src_prepare
#    eapply_user
#}

src_configure() {
    local mycmakeargs=(
        "-DRUN_LDCONFIG=OFF"
        "-DWITH_REGEXP=$(usex regexp)"
        "-DWITH_APACHE=$(usex apache)"
        "-DWITH_MYSQL=$(usex mysql)"
        "-DWITH_SQLITE=$(usex sqlite)"
        "-DWITH_SSL=$(usex ssl)"
        "-DWITH_UI=$(usex gtk)"
        "-DWITH_NEKOML=$(usex nekoml)"
    )
    cmake-utils_src_configure
}

src_compile() {
    cmake-utils_src_compile
}

src_install() {
    cmake-utils_src_install
}
