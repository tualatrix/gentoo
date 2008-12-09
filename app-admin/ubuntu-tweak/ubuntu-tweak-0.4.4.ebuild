# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Ubuntu Tweak is a tool for Ubuntu that makes it easy to configure
your system and desktop settings."
HOMEPAGE="http://ubuntu-tweak.com/"
#SRC_URI="http://ubuntu-tweak.googlecode.com/files/${PN}_${PV}.orig.tar.gz"
SRC_URI="http://ubuntu-tweak.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-python/pygtk
		sys-devel/gettext
		dev-util/intltool
		dev-util/pkgconfig
		"

RDEPEND="${DEPEND}
		dev-python/gnome-python-extras
		"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
