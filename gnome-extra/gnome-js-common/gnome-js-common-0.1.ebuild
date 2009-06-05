# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="a tool to generate images and thumbnails from HTML files"
HOMEPAGE="ftp://ftp.gnome.org/pub/gnome/sources/gnome-web-photo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gjs seed"

RDEPEND="gnome-base/gnome-light
			"
DEPEND="${RDEPEND}
		"
pkg_setup() {
	G2CONF="${G2CONF} $(use_enable gjs) $(use_enable seed)"
}
