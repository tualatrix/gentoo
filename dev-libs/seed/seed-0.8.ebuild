# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools gnome2 eutils

DESCRIPTION="The GObject introspection"
HOMEPAGE="http://live.gnome.org/GObjectIntrospection/"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="gnome-extra/gnome-js-common
		dev-libs/gobject-introspection
		media-libs/clutter
		dev-libs/gir-repository
		"
DEPEND="${RDEPEND}
	"
