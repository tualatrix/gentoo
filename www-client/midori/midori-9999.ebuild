# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-9999.ebuild,v 1.8 2008/10/27 19:17:29 jokey Exp $

inherit git eutils

DESCRIPTION="A lightweight web browser"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
EGIT_REPO_URI="git://git.xfce.org/kalikiana/midori"
EGIT_PROJECT="midori"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls soup sqlite"

DEPEND="x11-libs/gtk+
	net-libs/webkit-gtk
	nls? ( sys-devel/gettext )
	soup? ( net-libs/libsoup )
	sqlite? ( dev-db/sqlite )"

pkg_setup() {
	ewarn "Note: this software is not yet in a too mature status so expect some minor things to break"
}

src_compile() {
	./waf --prefix="/usr/" configure || die "waf configure failed."
	./waf build || die "waf build failed."
}

src_install() {
	DESTDIR=${D} ./waf install || die "waf install failed."
	dodoc AUTHORS ChangeLog INSTALL TODO
}
