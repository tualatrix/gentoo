# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-3.4.5.ebuild,v 1.8 2008/09/12 14:55:37 jer Exp $

inherit eutils gnome2

MY_PN="glade3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="GNOME GUI Builder"
HOMEPAGE="http://glade.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc gnome"

RDEPEND=">=dev-libs/glib-2.8.0
		 >=x11-libs/gtk+-2.12.0
		 >=dev-libs/libxml2-2.4
		 gnome?	(
					>=gnome-base/libgnomeui-2.0
					>=gnome-base/libbonoboui-2.0
				)"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19
		  app-text/scrollkeeper
		  app-text/gnome-doc-utils
		doc? ( >=dev-util/gtk-doc-1.4 )"

S="${WORKDIR}/${MY_P}"
DOCS="AUTHORS BUGS ChangeLog HACKING INTERNALS MAINTAINERS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable gnome) --disable-scrollkeeper"
}
