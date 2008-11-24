# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-aurora/gtk-engines-aurora-1.4.ebuild,v 1.3 2008/07/18 07:58:42 opfer Exp $

DESCRIPTION="GTK+ Css Engine"
HOMEPAGE="http://ftp.gnome.org/pub/GNOME/sources/gtk-css-engine"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/gtk-css-engine/0.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#S=${WORKDIR}/aurora-${PV}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
	insinto /usr/share/themes
}
