# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="a tool to generate images and thumbnails from HTML files"
HOMEPAGE="ftp://ftp.gnome.org/pub/gnome/sources/gnome-web-photo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="jpeg"

RDEPEND=">=dev-libs/glib-2.6.0
		>=x11-libs/gtk+-2.6.3
		>=dev-libs/libxml2-2.6.12
		media-libs/libpng
		gnome-base/gconf
		jpeg? ( media-libs/jpeg )
		|| ( www-client/mozilla-firefox
			net-libs/xulrunner
			www-client/seamonkey )"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable jpeg)"
}
