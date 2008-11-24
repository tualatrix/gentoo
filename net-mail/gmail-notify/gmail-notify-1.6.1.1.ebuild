# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python eutils multilib

DESCRIPTION="Gmail Notifier is a Linux alternative for the notifier program released by Google"
HOMEPAGE="http://gmail-notify.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="strip"

RDEPEND="dev-python/gnome-python-extras
	>=dev-python/pygtk-2.0"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	python_version
	unpack ${A}
	epatch "${FILESDIR}/${PN}-conf-perms.patch"
	epatch "${FILESDIR}/${PN}-trayicon.patch"
	epatch "${FILESDIR}/${PN}-ubuntu-patches.patch"
	cd "${S}"
	sed -i -e "s/GENTOO_PYVER/${PYVER}/g" notifier.py || die "Sed broke!"
	sed -i -e "s/GENTOO_PYVER/${PYVER}/g" GmailConfig.py || die "Sed broke!"
}

src_install() {
	python_version
	INST_DIR=/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}

	dodoc README

	insinto ${INST_DIR}
	doins *.py *.jpg *.png langs.xml pytrayicon.so notifier.conf.sample

	make_wrapper gmail-notify "/usr/bin/python ${INST_DIR}/notifier.py"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
	elog "Run gmail-notify to start the program"
	elog ""
	elog "Warning: if you check the 'save username and password' option"
	elog "your password will be stored in plaintext in ~/.notifier.conf"
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
}
