# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Store, Sync and Share Files Online"
HOMEPAGE="http://www.getdropbox.com/"
NMO_URL="http://dl.getdropbox.com/u/5143/nautilus-dropbox-packages/0.4.1/"
SRC_URI="${NMO_URL}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=" "

RDEPEND=">=gnome-base/nautilus-2.16
>=net-misc/wget-1.10"

DEPEND="${RDEPEND}
>=x11-libs/gtk+-2.12
>=dev-libs/glib-2.14
>=x11-libs/libnotify-0.4.4"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {

	econf || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
}


