# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://ubuntu-tweak.com/"
SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

OPT_DIR=${D}/opt/pagico
SERVICE_DIR=${D}/usr/share/dbus-1/system-services
SYSTEM_DIR=${D}/etc/dbus-1/system.d
DESKTOP_DIR=${D}/usr/share/applications

src_install(){
	mkdir -p $OPT_DIR
	cp -R ${S}/pagico/* $OPT_DIR
	mkdir -p $SERVICE_DIR
	cp ${S}/service/com.pagico.daemon.service $SERVICE_DIR
	mkdir -p $SYSTEM_DIR
	cp ${S}/service/pagico-daemon.conf $SYSTEM_DIR
	dobin ${S}/bin/pagico
	mkdir -p $DESKTOP_DIR
	cp ${S}/pagico.desktop $DESKTOP_DIR
}
