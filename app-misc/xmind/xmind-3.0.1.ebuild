# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://ubuntu-tweak.com/"
SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr
	cd ${S}
	doins -r *
	fperms 755 /usr/local/xmind/xmind
}
