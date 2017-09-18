# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# Ebuild metadata

EAPI=6

DESCRIPTION="The Haxe Cross-platform Toolkit. Includes the compiler and haxelib."
HOMEPAGE="https://haxe.org"
SRC_URI="https://github.com/HaxeFoundation/haxe/archive/3.4.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/haxe-3.4.3"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-haxe/neko
    dev-lang/ocaml
    dev-ml/camlp4
	dev-libs/libpcre
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

# Git information, needed for Makefile replacements

GIT_BRANCH="3.4.3"
GIT_COMMIT_SHA="e24c990"
GIT_COMMIT_TIMESTAMP="1505224814"

# Submodule tarballs corresponding to the 3.4.3 release

SUBMODULE_LIBS_COMMIT="5f7956d8a2f0a0d9b99339b793fb9a0a07288a20"
SUBMODULE_LIBS_URL="https://github.com/HaxeFoundation/ocamllibs/archive/${SUBMODULE_LIBS_COMMIT}.tar.gz"

SUBMODULE_HAXELIB_COMMIT="eeac8f4e77b23b120f27d27502f43589db26d143"
SUBMODULE_HAXELIB_URL="https://github.com/HaxeFoundation/haxelib/archive/${SUBMODULE_HAXELIB_COMMIT}.tar.gz"

# Ebuild phases

src_prepare() {
    # Replace git invocation with prepared variables since we use a source tarball and not the git repo
    # Also, replace the read/write permissions to all in a /usr location
    # TODO: Create a "haxelib" group that can write in the shared space
    sed -i \
        -e "s/git rev-parse --abbrev-ref HEAD/echo ${GIT_BRANCH}/" \
        -e "s/git rev-parse --short HEAD/echo ${GIT_COMMIT_SHA}/" \
        -e "s/git show -s --format=%ct HEAD/echo ${GIT_COMMIT_TIMESTAMP}/" \
        -e "s/chmod -R a+rx \$(INSTALL_LIB_DIR)/# chmod -R a+rx \$(INSTALL_LIB_DIR)/" \
        -e "s/chmod 777 \$(INSTALL_LIB_DIR)\/lib/# chmod 777 \$(INSTALL_LIB_DIR)\/lib/" \
        ${S}/Makefile

    # Replace the "libs" directory with its corresponding Git submodule
    rmdir ${S}/libs
    curl -# -L -o ${S}/libs.tar.gz ${SUBMODULE_LIBS_URL}
    if [[ $? != 0 ]] ; then
        die "Cannot fetch libraries from ${SUBMODULE_LIBS_URL}"
    fi
    tar -C ${S} -xzf ${S}/libs.tar.gz
    mv ${S}/ocamllibs-${SUBMODULE_LIBS_COMMIT} ${S}/libs
    rm ${S}/libs.tar.gz

    # Replace the "extra/haxelib_src" directory with of its corresponding Git submodule
    rmdir ${S}/extra/haxelib_src
    curl -# -L -o ${S}/extra/haxelib_src.tar.gz ${SUBMODULE_HAXELIB_URL}
    if [[ $? != 0 ]] ; then
        die "Cannot fetch Haxelib sources from ${SUBMODULE_HAXELIB_URL}"
    fi
    tar -C ${S}/extra -xzf ${S}/extra/haxelib_src.tar.gz
    mv ${S}/extra/haxelib-${SUBMODULE_HAXELIB_COMMIT} ${S}/extra/haxelib_src
    rm ${S}/extra/haxelib_src.tar.gz

    eapply_user
}

src_compile() {
    # TODO: Parallel build doesn't work at the moment
    emake -j1 || die "emake failed"
}

src_install() {
    # TODO: Parallel build doesn't work at the moment
    emake -j1 DESTDIR="${D}" install
}
