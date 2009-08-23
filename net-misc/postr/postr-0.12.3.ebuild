# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.6

inherit distutils

DESCRIPTION="Postr is a tool to upload photographs to Flickr, with tight integration into the GNOME desktop."
HOMEPAGE="http://burtonini.com"
SRC_URI="http://burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
	dev-python/twisted-web 
	dev-python/pygtk
	dev-python/gnome-python
	dev-python/nautilus-python
	"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="postr"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/desktop-mimetype.patch"
}
