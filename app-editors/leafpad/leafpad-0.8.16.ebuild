# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leafpad/leafpad-0.8.14.ebuild,v 1.3 2008/09/03 16:36:54 compnerd Exp $

inherit eutils gnome2 gnome2-utils

DESCRIPTION="Simple GTK+ Text Editor"
HOMEPAGE="http://tarot.freeshell.org/leafpad/"
SRC_URI="http://savannah.nongnu.org/download/leafpad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="emacs"

RDEPEND=">=x11-libs/gtk+-2.10"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.31
		>=dev-util/pkgconfig-0.9"

src_compile() {
	econf --enable-chooser --enable-print $(use_enable emacs)
	emake
}

pkg_preinst() {
	gnome2_icon_savelist
}

src_install() {
	# use emake install over einstall to prevent gtk-icon-theme-update from running
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	gnome2_icon_cache_update
}
