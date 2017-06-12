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
IUSE=""

DEPEND="dev-libs/boehm-gc
	dev-libs/openssl
	dev-libs/libpcre
	sys-libs/zlib
	www-servers/apache
	dev-libs/apr
	virtual/libmysqlclient
	dev-db/sqlite
	net-libs/mbedtls
	x11-libs/gtk+:2
"
RDEPEND="${DEPEND}"

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
