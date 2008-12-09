# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nm-applet/nm-applet-0.6.6.ebuild,v 1.3 2008/07/28 18:47:49 ken69267 Exp $

inherit gnome2 eutils

MY_P="${P/nm-applet/network-manager-applet}"

DESCRIPTION="Gnome applet for NetworkManager."
HOMEPAGE="http://people.redhat.com/dcbw/NetworkManager/"
SRC_URI="http://ftp.gnome.org/pub/gnome/sources/network-manager-applet/0.7/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=sys-apps/dbus-1.2
	>=sys-apps/hal-0.5.9
	>=dev-libs/libnl-1.1
	>=net-misc/networkmanager-0.7.0
	>=net-wireless/wireless-tools-28_pre9
	>=net-wireless/wpa_supplicant-0.5.7
	>=dev-libs/glib-2.16
	>=x11-libs/libnotify-0.4.3
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	>=gnome-base/gnome-keyring-2.20
	>=gnome-base/gnome-panel-2.20
	>=gnome-base/gconf-2.20
	>=gnome-base/libgnomeui-2.20
	>=gnome-extra/policykit-gnome-0.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
# USE_DESTDIR="1"

S=${WORKDIR}/${P/_rc2/}

pkg_setup () {
	G2CONF="${G2CONF} \
		--disable-more-warnings \
		--localstatedir=/var \
		--with-dbus-sys=/etc/dbus-1/system.d"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.7.0-confchanges.patch"
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "Your user needs to be in the plugdev group in order to use this"
	elog "package.  If it doesn't start in Gnome for you automatically after"
	elog 'you log back in, simply run "nm-applet --sm-disable"'
	elog "You also need the notification area applet on your panel for"
	elog "this to show up."
}
