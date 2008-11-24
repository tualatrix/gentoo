# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gtk-sharp-module

SLOT="2"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
	>=gnome-base/libglade-2.3.6
	dev-util/pkgconfig"
