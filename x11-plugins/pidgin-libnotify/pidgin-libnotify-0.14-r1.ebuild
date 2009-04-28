# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-libnotify/pidgin-libnotify-0.14.ebuild,v 1.1 2009/02/01 02:01:38 tester Exp $

inherit eutils

DESCRIPTION="pidgin-libnotify provides popups for pidgin via a libnotify interface"
HOMEPAGE="http://gaim-libnotify.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim-libnotify/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="nls debug"

RDEPEND=">=x11-libs/libnotify-0.3.2
	net-im/pidgin
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use net-im/pidgin gtk; then
		eerror "You need to compile net-im/pidgin with USE=gtk"
		die "Missing gtk USE flag on net-im/pidgin"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/pidgin-libnotify-showbutton.patch
	epatch "${FILESDIR}"/no-action.patch
}

src_compile() {
	local myconf

	myconf="$(use_enable debug) \
			$(use_enable nls)"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO VERSION
}
