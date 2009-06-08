# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit autotools python clutter

DESCRIPTION="Python bindings for Clutter"

KEYWORDS="~amd64 ~x86"
IUSE="cairo doc examples gstreamer gtk"

RDEPEND="dev-lang/python:2.5
	dev-python/pygobject
	>=media-libs/clutter-0.8.4:${SLOT}
	cairo? ( media-libs/clutter-cairo:${SLOT} )
	gstreamer? ( media-libs/clutter-gst:${SLOT} )
	gtk? ( >=media-libs/clutter-gtk-0.8.2:${SLOT} )
"
DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt )
	cairo? ( dev-python/pycairo )
	gstreamer? (
		media-libs/gstreamer
		dev-python/gst-python )
	gtk? ( dev-python/pygtk )
"
DOCS="AUTHORS ChangeLog NEWS README TODO"
EXAMPLES="examples/*"

src_prepare() {
	epatch "${FILESDIR}/${PN}-fix-docs-install-data-hook.patch"

	eautoreconf
	ln -sf $(type -P true) py-compile
}

src_configure() {
	local myconf="
		$(use_with cairo cluttercairo)
		$(use_with gstreamer cluttergst)
		$(use_with gtk cluttergtk)
		$(use_enable doc docs)"
	
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	clutter_src_install
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/clutter*
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/clutter*
}
