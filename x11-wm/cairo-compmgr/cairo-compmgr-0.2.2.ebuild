# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://cairo-compmgr.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/ccm/cairo-compmgr/${P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

#S="${WORKDIR}/${P}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	#einstall || die "einstall failed"
}
