# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-0.12.1.ebuild,v 1.5 2008/11/26 23:26:31 loki_val Exp $

EAPI=2

inherit eutils gnome2 mono

DESCRIPTION="Tasque is a simple task management app (TODO list) for the Linux
Desktop."
HOMEPAGE="http://live.gnome.org/Tasque"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="sqlite"

RDEPEND=">=dev-lang/mono-2"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

src_configure() {
	G2CONF="${G2CONF} $(use_enable sqlite backend-sqlite)"
#	gnome2_src_configure
}
