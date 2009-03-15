# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do/gnome-do-0.8.0.ebuild,v 1.1 2009/02/01 18:01:24 graaff Exp $

# TODO: GNOME Do defaults to a debug build; to disable, --enable-release must
# be passed. However, when doing this the build fails; figure out why.

EAPI=2

inherit gnome2 mono versionator eutils

PVC=$(get_version_component_range 1-3)

DESCRIPTION="GNOME Do allows you to get things done quickly"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="http://launchpad.net/do/0.8/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/gconf-sharp-2.24.0
	>=dev-dotnet/gtk-sharp-2.12.6
	>=dev-dotnet/glade-sharp-2.12.6
	dev-dotnet/dbus-sharp
	dev-dotnet/dbus-glib-sharp
	>=dev-dotnet/gnome-desktop-sharp-2.24.0
	>=dev-dotnet/gnome-keyring-sharp-1.0.0
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gnomevfs-sharp-2.24.0
	>=dev-dotnet/wnck-sharp-2.24.0
	>=dev-dotnet/art-sharp-2.24.0
	dev-dotnet/mono-addins
	dev-dotnet/notify-sharp
	dev-dotnet/rsvg-sharp
	!<gnome-extra/gnome-do-plugins-0.8"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	gnome2_src_configure
}

src_compile() {
	default
}

pkg_postinst() {
	gnome2_pkg_postinst
}
