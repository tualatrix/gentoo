# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

GTK_SHARP_MODULE_DEPS="art"
GTK_SHARP_REQUIRED_VERSION="2.12"

inherit gtk-sharp-module

SLOT="2"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
	>=gnome-base/libgnomecanvas-2.20
	>=gnome-base/libgnomeui-2.20
	>=x11-libs/gtk+-2.12
	>=gnome-base/libgnomeprintui-2.18
	>=gnome-base/gnome-panel-2.20
	~dev-dotnet/gnomevfs-sharp-${PV}
	~dev-dotnet/art-sharp-${PV}"
