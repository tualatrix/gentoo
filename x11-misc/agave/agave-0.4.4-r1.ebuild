# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# 

inherit eutils gnome2

DESCRIPTION="Agave is a color scheme designer for the GNOME Desktop."
HOMEPAGE="http://home.gna.org/colorscheme/"
SRC_URI="http://download.gna.org/colorscheme/releases/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="gnome test debug"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=dev-cpp/gtkmm-2.8.0
         >=dev-cpp/libglademm-2.4
	dev-libs/boost
	gnome? ( >=gnome-base/libgnomeui-2.0 >=dev-cpp/gconfmm-2.6 )
	test? ( >=dev-util/cppunit-1.10.0 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21
	>=app-text/scrollkeeper-0.3.5"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} \
	`use_with gnome` \
	`use_with gnome gconf` \
	`use_with test` \
	`use_with debug`"

USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/agave-4.4-gcc-4.3.patch
}


src_install() {
	gnome2_src_install

	# Fix the icon name in the desktop file.
	dosed "s:Icon=agave-icon.png:Icon=agave.png:" \
			/usr/share/applications/agave.desktop
}
