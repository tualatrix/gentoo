# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=1

inherit gnome2

DESCRIPTION="Clutter-GTK - GTK+ Integration library for Clutter"

KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=">=x11-libs/gtk+-2.12
		>=media-libs/clutter-0.8.7"

DEPEND="${RDEPEND}"
SLOT=0

DOCS="AUTHORS ChangeLog NEWS README TODO"
EXAMPLES=examples/{*.c,redhand.png}
