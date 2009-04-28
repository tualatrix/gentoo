# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notification-daemon/notification-daemon-0.4.0.ebuild,v 1.9 2009/04/05 14:12:08 klausman Exp $

WANT_AUTOMAKE="1.9"

inherit gnome2 eutils

DESCRIPTION="Notifications daemon"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://code-of-tualatrix.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="gstreamer"

RDEPEND=">=dev-libs/glib-2.4.0
		 >=x11-libs/gtk+-2.4.0
		 >=gnome-base/gconf-2.4.0
		 >=x11-libs/libsexy-0.1.3
		 >=dev-libs/dbus-glib-0.71
		 x11-libs/libwnck
		 ~x11-libs/libnotify-0.4.5
		 >=gnome-base/libglade-2
		 gstreamer? ( >=media-libs/gstreamer-0.10 )"
DEPEND="${RDEPEND}
		dev-util/intltool
		>=sys-devel/gettext-0.14
		!xfce-extra/notification-daemon-xfce
		!x11-misc/xfce4-notifyd"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS"
	G2CONF="$(use_enable gstreamer sound gstreamer)"
}
