# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator-extras/avant-window-navigator-extras-0.2.6-r1.ebuild,v 1.7 2008/12/04 21:50:23 eva Exp $

inherit autotools eutils gnome2 python

MY_P="awn-extras-applets-${PV}"
DESCRIPTION="Applets for the avant-window-navigator"
HOMEPAGE="http://launchpad.net/awn-extras"
SRC_URI="http://launchpad.net/awn-extras/0.2/0.3.2/+download/awn-extras-applets-0.3.2.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="dev-python/pyalsaaudio
	dev-python/feedparser
	gnome? (
		dev-python/gst-python
		dev-python/gnome-python-desktop
		gnome-base/gnome-menus
		gnome-base/librsvg
		gnome-base/libgtop
	)
	gnome-extra/avant-window-navigator
	x11-libs/libsexy
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

DOCS="AUTHORS Changelog NEWS README"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use gnome && ! built_with_use gnome-extra/avant-window-navigator gnome ; then
		eerror "Please re-emerge gnome-extra/avant-window-navigator with the gnome USE flag set"
		die "avant-window-navigator needs the gnome flag set"
	fi
}

src_compile() {
	# Not disabling pymod-checks results in a sandbox access violation.
	econf --disable-pymod-checks \
		$(use_with gnome) \
		$(use_with gnome gconf)

	# temp hack to remove problem per bug #214984
	if ! use gnome && ! use xfce; then
		sed -i -e 's:--makefile-install-rule $(schemas_DATA)::' \
			"${S}/src/places/Makefile"
		sed -i -e 's:--makefile-install-rule $(schemas_DATA)::' \
			"${S}/src/shiny-switcher/Makefile"
	fi

	emake || die "emake failed"
}

src_install() {
	gnome2_src_install

	if use gnome ; then
		# Give the gconf schemas non-conflicting names.
		mv "${D}/etc/gconf/schemas/notification-daemon.schemas" \
			"${D}/etc/gconf/schemas/awn-notification-daemon.schemas"
		mv "${D}/etc/gconf/schemas/awnsystemmonitor.schemas" \
			"${D}/etc/gconf/schemas/awn-system-monitor.schemas"
		mv "${D}/etc/gconf/schemas/filebrowser.schemas" \
			"${D}/etc/gconf/schemas/awn-filebrowser.schemas"
		mv "${D}/etc/gconf/schemas/switcher.schemas" \
			"${D}/etc/gconf/schemas/awn-switcher.schemas"
		mv "${D}/etc/gconf/schemas/trash.schemas" \
			"${D}/etc/gconf/schemas/awn-trash.schemas"
		mv "${D}/etc/gconf/schemas/shinyswitcher.schemas" \
			"${D}/etc/gconf/schemas/awn-shinyswitcher.schemas"
		mv "${D}/etc/gconf/schemas/places.schemas" \
			"${D}/etc/gconf/schemas/awn-places.schemas"
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/awn/extras
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/awn/extras
}
