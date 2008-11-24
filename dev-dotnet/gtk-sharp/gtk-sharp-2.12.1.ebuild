# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils mono autotools

DESCRIPTION="GtkSharp is a C# language binding for the GTK2 toolkit and GNOME libraries"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"
SRC_URI="mirror://gnome/sources/${PN}/${PV%.*}/${P}.tar.bz2
	mirror://gentoo/${PN}-2.12.1-configurable.diff.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="dev-lang/mono
	>=x11-libs/gtk+-2.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/monodoc )"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Make the individual components selectable at configure.
	epatch "${WORKDIR}/${PN}-2.12.1-configurable.diff"

	sed -i -e ':^CFLAGS=:d' "${S}/configure.in"

	# Fix up pkgconfig entries.
	sed -i -e 's:^prefix.*:prefix=@prefix@:' \
	       -e 's:^libdir.*:libdir=@libdir@:' \
	"${S}"/*/*.pc.in || die

	eautoreconf

	# Disable building of samples, #16015.
	sed -i -e "s:sample::" Makefile.in
}

src_compile() {
	econf --disable-glade || die "econf failed"
	LANG=C emake -j1 || die "emake failed"
}

src_install () {
	LANG=C emake GACUTIL_FLAGS="/root "${D}"/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}-2.0" \
			DESTDIR="${D}" install || die "emake install failed"

	dodoc README* ChangeLog
}
