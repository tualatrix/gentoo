# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do-plugins/gnome-do-plugins-0.6.0.1.ebuild,v 1.1 2008/12/13 15:13:18 graaff Exp $

inherit eutils autotools gnome2 mono versionator

MY_PN="do-plugins"
PVC=$(get_version_component_range 1-2)
PVC2=$(get_version_component_range 1-3)

DESCRIPTION="Plugins to put the Do in Gnome Do"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/${MY_PN}/${PVC}/${PVC2}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=gnome-extra/gnome-do-${PV}
		dev-dotnet/wnck-sharp"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/monodevelop"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-disable-evo-flickr.patch"
	epatch "${FILESDIR}/debug.patch"
	eautoreconf
}

src_compile()
{
	econf --enable-debug=no --enable-release=yes || die "configure failed"
	emake || die "make failed"
}

pkg_postinst()
{
	ewarn "Plugin handling has changed since gnome-do 0.4."
	ewarn "If you install the gnome-do-plugins package you will have local copies"
	ewarn "of the plugins, but you still need to manually enable them in Preferences."
	ewarn "Also note that plugins installed from upstream may not be compatible with"
	ewarn "your system. When in doubt check the output from gnome-do itself".
	ewarn "Old plugins may not be compatible either."
	ewarn "Check ~/.local/share/gnome-do/ if you have problems with plugins."
}
