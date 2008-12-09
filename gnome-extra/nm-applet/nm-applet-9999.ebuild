# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2 subversion autotools eutils

MY_PV=${PV/_*/}

DESCRIPTION="SVN snap of Gnome applet for NetworkManager."
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
ESVN_REPO_URI="svn://svn.gnome.org/svn/network-manager-applet/trunk"

SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
#IUSE=""

RDEPEND=">=sys-apps/dbus-1.2
	>=sys-apps/hal-0.5.9
	>=dev-libs/libnl-1.1
	>=net-misc/networkmanager-0.7.0_pre20080817
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

pkg_setup () {
	G2CONF="${G2CONF} \
		--disable-more-warnings \
		--localstatedir=/var \
		--with-dbus-sys=/etc/dbus-1/system.d"
}

src_unpack() {
	subversion_src_unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.7.0-confchanges.patch"
	intltoolize
	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "Your user needs to be in the plugdev group in order to use this"
	elog "package.  If it doesn't start in Gnome for you automatically after"
	elog 'you log back in, simply run "nm-applet --sm-disable"'
	elog "You also need the notification area applet on your panel for"
	elog "this to show up."
}
