# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

HOMEPAGE="http://www.pagico.com/"
DESCRIPTION="Pagico keeps track of all your tasks, projects, and contacts."
SRC_URI="http://downloads.imtx.cn/gentoo/${P}.tar.bz2"

LICENSE="pagico"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/gtk+
	dev-libs/dbus-glib
	net-libs/webkit-gtk
	dev-python/dbus-python"
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
	dobin ${S}/bin/pagico-helper
	mkdir -p $DESKTOP_DIR
	cp ${S}/pagico.desktop $DESKTOP_DIR
}
