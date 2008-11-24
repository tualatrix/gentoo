# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mono

DESCRIPTION="C# implementation of gnome-keyring"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://ftp.novell.com/pub/mono/sources/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="dbus doc"

RDEPEND="dev-lang/mono
	dbus? ( dev-dotnet/dbus-sharp )
	doc? ( dev-util/monodoc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix the pkgconfig entry to contain a correct libdir value.
	sed -i -e 's:^libdir.*:libdir=@libdir@:' "${S}"/src/*.pc.in \
			|| die "sed failed"
	
	# Disable building samples.
	sed -i -e 's:sample::' "${S}"/Makefile.in || die "sed failed"
}

src_compile() {
	econf $(use_enable dbus) || die "econf failed"

	# This dies a horrible death with anything other than "-j1".
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
