# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Lightweight integrated development environment"
HOMEPAGE="http://trolltech.com/developer/qt-creator/qt-creator"
SRC_URI="amd64? ( ftp://ftp.trolltech.com/qtcreator/${P}-linux-x86_64-setup.bin )
	x86? ( ftp://ftp.trolltech.com/qtcreator/${P}-linux-x86-setup.bin )"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="strip"

DEPEND="x11-libs/qt:4"
RDEPEND="${DEPEND}"

src_unpack() {
	chmod a+x "$DISTDIR/${A}"
	"$DISTDIR/${A}" --mode unattended --installdir "${S}" || die "Failed to unpack"
}

src_install() {
	local dirs="bin doc lib"

	dodir /opt/${P}
	cp -pPR ${dirs} "${D}/opt/${P}/" || die "failed to copy"

	dodir /usr/bin
	cat > "${D}/usr/bin/qtcreator" <<__END__
#!/bin/sh
QT_PLUGIN_PATH="" /opt/${P}/bin/qtcreator
__END__
	chmod a+x "${D}/usr/bin/qtcreator"
	    
	cp "${S}/bin/Nokia-QtCreator-48.png" "${T}/qtcreator.png"
	doicon "${T}/qtcreator.png"
	make_desktop_entry qtcreator "QtCreator ${PV}" \
	"qtcreator.png" "Application;Development"
}
