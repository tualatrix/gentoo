# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Shutter - Featureful Screenshot Tool"
HOMEPAGE="https://launchpad.net/shutter"
SRC_URI="https://launchpad.net/~shutter/+archive/ppa/+files/shutter_0.80~ppa8.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
	dev-perl/gtk2-perl
	dev-perl/gtk2-trayicon
	dev-perl/gnome2-perl
	dev-perl/gnome2-wnck
	dev-perl/gnome2-gconf
	dev-perl/Goo-Canvas
	dev-perl/Gtk2-ImageView
	dev-perl/gnome2-vfs-perl
	dev-perl/libxml-perl
	media-gfx/imagemagick
	dev-perl/X11-Protocol
	dev-perl/WWW-Mechanize
	gnome-extra/gnome-web-photo
"
RDEPEND="${DEPEND}"

#S="${WORKDIR}/shutter-0.70.orig"

src_install() {
	dobin ${S}/bin/shutter
	cp -r ${S}/share ${D}/usr/share
}
