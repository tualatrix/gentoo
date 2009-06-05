# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

MY_DIR=$(get_version_component_range 1-2)

DESCRIPTION="Clutter is a library for creating graphical user interfaces"
HOMEPAGE="http://www.clutter-project.org/"
SRC_URI="http://www.clutter-project.org/sources/${PN}/${MY_DIR}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# Dependency on gtk+ is for GdkPixBuf;
# change if/when GdkPixBuf separates.
RDEPEND="
	virtual/opengl
	>=dev-libs/glib-2.14.0
	>=x11-libs/pango-1.18
	>=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}
		>=dev-util/gtk-doc-1 "

src_compile() {
	epatch "$FILESDIR/animatev-annotation.patch" 
}

src_install() {
	econf --enable-introspection|| die "econf failed"
	emake || die "emake failed"

	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
