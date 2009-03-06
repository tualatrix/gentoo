# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib python eutils autotools

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="avahi dbus gnome idle libnotify nls spell srv trayicon X xhtml"

DEPEND="|| (
		( <dev-lang/python-2.5 dev-python/pysqlite )
		>=dev-lang/python-2.5[sqlite]
	)
	dev-python/pygtk
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

RDEPEND="gnome? ( dev-python/gnome-python-extras
		dev-python/gnome-python-desktop
	)
	dbus? ( dev-python/dbus-python dev-libs/dbus-glib )
	libnotify? ( x11-libs/libnotify )
	xhtml? ( dev-python/docutils )
	srv? ( net-dns/bind-tools )
	idle? ( x11-libs/libXScrnSaver )
	spell? ( app-text/gtkspell )
	avahi? ( net-dns/avahi[dbus,gtk,python] )
	dev-python/pyopenssl
	dev-python/sexy-python
	dev-python/pycrypto"

pkg_setup() {
	if ! use dbus; then
		if use libnotify; then
			eerror "The dbus USE flag is required for libnotify support"
			die "USE=\"dbus\" needed for libnotify support"
		fi
		if use avahi; then
			eerror "The dbus USE flag is required for avahi support"
			die "USE=\"dbus\" needed for avahi support"
		fi
	fi
}

src_prepare() {
	# bug #251466 move *.py out of /usr/share
	# upstream: (http://trac.gajim.org/ticket/4770)
	epatch "${FILESDIR}/fix_autotools_and_search_dirs.patch"
	# not upstream:
	epatch "${FILESDIR}/0.12.1_autotools_install_pyfiles_in_pkglibdir.patch"
	# fix datadir path (trunk use an env var for config this)
	sed -i "s|'DATA',.*|'DATA', '/usr/share/gajim/data')|" \
		   "src/common/configpaths.py" || die 'sed failed'

	eautoreconf
}

src_configure() {
	local myconf

	if ! use gnome; then
		myconf="${myconf} $(use_enable trayicon)"
		myconf="${myconf} $(use_enable idle)"
	fi

	econf $(use_enable nls) \
		$(use_enable spell gtkspell) \
		$(use_enable dbus remote) \
		$(use_with X x) \
		--docdir="/usr/share/doc/${PF}" \
		--libdir="$(python_get_sitedir)" \
		${myconf} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm "${D}/usr/share/doc/${PF}/README.html"
	dohtml README.html
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/gajim/
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/gajim/
}
