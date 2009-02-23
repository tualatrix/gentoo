# ==========================================================================
# This ebuild come from desktop-effects repository. Zugaina.org only host a copy.
# For more info go to http://gentoo.zugaina.org/
# ************************ General Portage Overlay ************************
# ==========================================================================
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils eutils

DESCRIPTION="Screenlets are small owner-drawn applications"
HOMEPAGE="http://www.screenlets.org"
SRC_URI="http://code.launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"
S="${WORKDIR}/${PN}"

RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/dbus-python
	dev-python/gnome-python-desktop
	dev-python/pycairo
	>=dev-python/pygtk-2.10.0
	dev-python/pyxdg
	x11-libs/libnotify
	x11-misc/notification-daemon
	x11-misc/xdg-utils"

RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install

	insinto /usr/share/desktop-directories
	doins "${S}"/desktop-menu/desktop-directories/Screenlets.directory

	insinto /usr/share/icons
	doins "${S}"/desktop-menu/screenlets.svg

	# Insert .desktop files
	for x in $(find "${S}"/desktop-menu -name "*.desktop"); do
		domenu ${x}
	done
}
