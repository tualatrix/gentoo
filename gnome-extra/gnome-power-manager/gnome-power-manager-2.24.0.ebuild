# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-power-manager/gnome-power-manager-2.22.1.ebuild,v 1.8 2008/08/10 12:44:55 maekke Exp $

inherit eutils gnome2 virtualx

DESCRIPTION="Gnome Power Manager"
HOMEPAGE="http://www.gnome.org/projects/gnome-power-manager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="doc policykit test"

# See bug #196490
RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.6.0
		 >=x11-libs/gtk+-2.11.0
		 >=gnome-base/gnome-keyring-0.6.0
		 >=gnome-base/libgnome-2.14.0
		 >=gnome-base/libgnomeui-2.14.0
		 >=sys-apps/hal-0.5.9
		 >=dev-libs/dbus-glib-0.71
		 >=gnome-base/libglade-2.5.0
		 >=x11-libs/libnotify-0.4.3
		 >=x11-libs/libwnck-2.10.0
		 >=x11-libs/cairo-1.0.0
		 >=gnome-base/gnome-panel-2
		 >=gnome-base/gconf-2
		  =media-libs/gstreamer-0.10*

		 >=x11-apps/xrandr-1.2

		   x11-libs/libX11
		   x11-libs/libXext"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		 ~app-text/docbook-xml-dtd-4.3
		>=dev-util/pkgconfig-0.9
		>=dev-util/intltool-0.35
		  app-text/scrollkeeper
		>=app-text/gnome-doc-utils-0.3.2
		doc?	(
					 app-text/xmlto
					 app-text/docbook-sgml-utils
					~app-text/docbook-xml-dtd-4.4
					~app-text/docbook-sgml-dtd-4.1
					~app-text/docbook-xml-dtd-4.1.2
				)"

# docbook-sgml-utils and docbook-sgml-dtd-4.1 used for creating man pages
# (files under ${S}/man).
# docbook-xml-dtd-4.4 and -4.1.2 are used by the xml files under ${S}/docs.

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable test tests)
		$(use_enable doc docbook-docs)
		$(use_enable policykit)
		$(use_enable policykit gconf-defaults)
		--with-dpms-ext
		--enable-xevents
		--enable-applets"
}

src_unpack() {
	gnome2_src_unpack

	if use doc; then
		# Actually install all html files, not just the index
		sed -i -e 's:\(htmldoc_DATA = \).*:\1$(SPEC_HTML_FILES):' \
			"${S}/docs/Makefile.am"
	else
		# Remove the docbook2man rules here since it's not handled by a proper
		# parameter in configure.in.
		sed -i -e 's:@HAVE_DOCBOOK2MAN_TRUE@.*::' "${S}/man/Makefile.am"
	fi

	# glibc splits this out, whereas other libc's do not tend to
	use elibc_glibc || sed -i -e 's/-lresolv//' configure
}

src_test() {
	Xemake check || die "Test phase failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog
	elog "To enable frequency scaling interface, use the following command:"
	elog "	gconftool-2 /apps/gnome-power-manager/ui/cpufreq_show"
	elog "Note that this will conflict with other power managment utility"
	elog "like app-laptop/laptop-mode-tools."
	elog
}
