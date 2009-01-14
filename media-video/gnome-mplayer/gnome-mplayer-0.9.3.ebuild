# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="1"
inherit autotools eutils gnome2

DESCRIPTION="MPlayer GUI for GNOME Desktop Environment"
HOMEPAGE="http://code.google.com/p/gnome-mplayer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa gnome ipod libnotify musicbrainz"

# glib higher version for gio
RDEPEND="
	>=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.12
	>=sys-apps/dbus-0.95
	>=dev-libs/dbus-glib-0.70
	media-video/mplayer
	alsa? ( media-libs/alsa-lib )
	gnome? ( gnome-base/gconf:2 )
	ipod? ( media-libs/libgpod )
	libnotify? ( x11-libs/libnotify )
	musicbrainz? ( media-libs/musicbrainz:3 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

G2CONF="
	--with-gio
	$(use_with alsa)
	$(use_with gnome gconf)
	$(use !gnome && echo '--disable-schemas-install')
	$(use_with ipod libgpod)
	$(use_with libnotify)
	$(use_with musicbrainz libmusicbrainz3)"

DOCS="ChangeLog README INSTALL
	DOCS/keyboard_shortcuts.txt
	DOCS/tech/dbus.txt
	DOCS/tech/plugin-interaction.txt"

src_unpack() {
	gnome2_src_unpack

	epatch "${FILESDIR}"/sandbox-violation-${PV}.patch
	eautoreconf || die "eautoreconf failed"
}

src_install() {
	gnome2_src_install

	# remove docs in DOCS and empty dir
	rm -rf "${D}"/usr/share/doc/${PN}
	rmdir -p "${D}"/var/lib
}

