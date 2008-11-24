# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils mono

DESCRIPTION="notify-sharp is a C# client implementation for Desktop Notifications"
HOMEPAGE="http://www.ndesk.org/NotifySharp"
SRC_URI="http://dev.gentoo.org/~suka/files/${P}.tar.gz"
LICENSE="AS-IS"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND=">=dev-lang/mono-1.1.13
	>=dev-dotnet/gtk-sharp-2.6
	>=dev-dotnet/dbus-sharp-0.4
	>=dev-dotnet/dbus-glib-sharp-0.3"

DEPEND="${RDEPEND}
	doc? ( dev-util/monodoc )"
	
src_compile() {
	export GACUTIL_FLAGS="-root ${D}/usr/$(get_libdir) -gacdir /usr/$(get_libdir) -package ${PN}-${SLOT}"

	econf $(use_enable doc docs) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
}

