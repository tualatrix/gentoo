# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO: GNOME Do defaults to a debug build; to disable, --enable-release must
# be passed. However, when doing this the build fails; figure out why.

inherit gnome2 mono versionator

PVC=$(get_version_component_range 1-3)

DESCRIPTION="GNOME Do allows you to quickly search for many items and perform useful actions on those items"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/do/${PV:0:3}/${PVC}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="eds gnome"

RDEPEND="dev-lang/mono
	>=dev-dotnet/gconf-sharp-2.0
	>=dev-dotnet/glade-sharp-2.0
	>=dev-dotnet/gtk-sharp-2.0
	>=dev-dotnet/gnomedesktop-sharp-2.0
	dev-dotnet/gnome-keyring-sharp
	>=dev-dotnet/gnome-sharp-2.0
	>=dev-dotnet/gnomevfs-sharp-2.0
	dev-dotnet/mono-addins
	dev-dotnet/dbus-sharp
	dev-dotnet/dbus-glib-sharp
	dev-dotnet/notify-sharp
	!gnome-extra/gnome-do-plugins
	eds? ( dev-dotnet/evolution-sharp )
	gnome? ( dev-dotnet/wnck-sharp )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

# Looks like someone forgot to rename the source directory.
S="${WORKDIR}/${PN}-0.6.1.0"

pkg_postinst() {
	gnome2_pkg_postinst

	elog "As of gnome-do-0.5 the plugins have been merged into the main"
	elog "package, making gnome-extra/gnome-do-plugins obsolete."
}
