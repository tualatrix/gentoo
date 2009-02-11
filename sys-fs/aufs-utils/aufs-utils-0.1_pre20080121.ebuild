# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils cvs

DESCRIPTION="Userspace utilities for aufs."
HOMEPAGE="http://aufs.sourceforge.net/"
SRC_URI=""

ECVS_SERVER="aufs.cvs.sourceforge.net:/cvsroot/aufs"
ECVS_MODULE="aufs"
CVS_DATE="${PV/0.1_pre/}"
ECVS_CO_OPTS="-D${CVS_DATE}"
ECVS_UP_OPTS="-D${CVS_DATE} ${ECVS_UP_OPTS}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="!sys-fs/aufs ${DEPEND}"

S="${WORKDIR}/aufs"

src_compile() {
	emake -f local.mk aufs.5 mount.aufs auplink aulchown umount.aufs \
		|| die "emake failed"
}

src_install() {
	exeinto /sbin
	exeopts -m0500
	doexe mount.aufs umount.aufs auplink aulchown
	doman aufs.5
}
