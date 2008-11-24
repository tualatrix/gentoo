# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

KEYWORDS="~x86"
DESCRIPTION="GmailFS provides a mountable Linux filesystem which uses your Gmail account as its storage medium."
HOMEPAGE="http://richard.jones.name/google-hacks/gmail-filesystem/gmail-filesystem.html"
SRC_URI="http://richard.jones.name/google-hacks/gmail-filesystem/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/python-2.3
	>=dev-python/fuse-python-0.2
	>=sys-fs/fuse-1.3
	>=net-libs/libgmail-0.1.3.3"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/${P}.patch || die "patching failed"
}

src_install() {
	exeinto /sbin
	doexe ${WORKDIR}/${P}/mount.gmailfs || die "Can't write to /sbin"
	dosym /sbin/mount.gmailfs /usr/bin/mount.gmailfs
	insinto /etc
	doins ${WORKDIR}/${P}/gmailfs.conf || die "Can't write to /etc"
	exeinto /usr/share/${PN}
	doexe ${WORKDIR}/${P}/gmailfs.py || die "Can't doexe"
	dodoc COPYING ChangeLog
}

pkg_postinst() {
	einfo "You should now be able to mount gmailfs."
	einfo "To mount from the command line, do:"
	einfo "mount.gmailfs none /path/of/mount/point"
	einfo "To use fstab, create an entry /etc/fstab that looks something like:"
	einfo "none /path/of/mount/point gmailfs noauto[,options]"
	einfo " "
	ewarn "Remember to choose a very creative, unguessable fsname, else someone"
	ewarn "could manipulate your filesystem. Also remember that gmailfs is a"
	ewarn "cruel hack. So don't expect things like good performance"
	einfo " "
	ewarn "This program is NOT SUPPORTED by Google, and may well be a"
	ewarn "violation of the Gmail Terms of Service!"
	einfo " "
	ewarn "USE AT YOUR OWN RISK!!!"
	einfo " "
}
