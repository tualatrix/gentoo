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
IUSE="debug doc eglx eglnative fruity internal osx sdl win32 X xinput"

# Dependency on gtk+ is for GdkPixBuf;
# change if/when GdkPixBuf separates.
RDEPEND="
	virtual/opengl
	>=dev-libs/glib-2.14.0
	>=x11-libs/pango-1.18
	!internal? ( !osx? ( >=x11-libs/gtk+-2.0 ) )
	sdl? ( media-libs/libsdl )"

DEPEND="${RDEPEND}
		doc? ( >=dev-util/gtk-doc-1 
		       app-text/docbook-sgml-utils
			   app-text/xmlto )"

src_compile() {
	CONF="${CONF} \
			$(use_enable doc gtk-doc) \
			$(use_enable doc manual) \
			$(use_enable debug) \
			$(use_enable xinput) \
			$(use_with X x)"

	# Depend on plain X11 backend by
	# default
	if use sdl; then
		elog "Using SDL for OpenGL backend"
		CONF="${CONF} --with-flavour=sdl"
	elif use eglx; then
		elog "Using eglx for OpenGL backend"
		CONF="${CONF} --with-flavour=eglx"
	elif use eglnative; then
		elog "Using native egl OpenGL backend"
		CONF="${CONF} --with-flavour=eglnative"
	elif use osx; then
		elog "Using OSX OpenGL backend"
		CONF="${CONF} --with-flavour=osx"
	elif use win32; then
		elog "Using Win32 OpenGL backend"
		CONF="${CONF} --with-flavour=win32"
	elif use fruity; then
		elog "Using fruity OpenGL backend"
		CONF="${CONF} --with-flavour=fruity"
	else
		elog "Using glx for OpenGL backend"
		CONF="${CONF} --with-flavour=glx"
	fi
	if use internal; then
		elog "Using internal image backend"
		CONF="${CONF} --with-imagebackend=internal"
	elif use osx; then
		elog "Using quartz for image backend"
		CONF="${CONF} --with-imagebackend=quartz"
	else
		elog "Using gdk-pixbuf for image backend"
		CONF="${CONF} --with-imagebackend=gdk-pixbuf"
	fi
	econf ${CONF} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
