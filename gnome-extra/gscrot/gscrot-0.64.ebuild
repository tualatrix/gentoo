# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="GScrot - Screenshot Tool"
HOMEPAGE="https://launchpad.net/gscrot"
SRC_URI="http://launchpadlibrarian.net/20864797/gscrot_0.64~ppa12.orig.tar.gz"

LICENSE=""

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="
dev-perl/gtk2-perl
dev-perl/gtk2-trayicon
dev-perl/gnome2-perl
dev-perl/gnome2-wnck
dev-perl/gnome2-gconf
media-gfx/imagemagick
net-print/gtklp
dev-perl/X11-Protocol
dev-perl/WWW-Mechanize
gnome-extra/gnome-web-photo"

RDEPEND="${DEPEND}"

S="${WORKDIR}/gscrot-0.64.orig"

src_install() {
	dobin ${S}/bin/gscrot

	cp -r ${S}/share ${D}/usr/share
}
