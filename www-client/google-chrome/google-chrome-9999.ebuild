# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

EGCLIENT_REPO_URI="http://src.chromium.org/svn/trunk/src/"
EGCLIENT_CONFIG="${FILESDIR}/.gclient"

inherit gclient eutils

RESTRICT="mirror"

DESCRIPTION="Chromium is the open-source project behind Google Chrome."
HOMEPAGE="http://code.google.com:80/chromium/"

LICENSE="GPL-2"
SLOT="live"

IUSE=""

DEPEND="
	>=dev-lang/python-2.4
	>=dev-lang/perl-5.0
	>=sys-devel/gcc-4.2
	>=sys-devel/bison-2.3
	>=sys-devel/flex-2.5.34
	>=dev-util/gperf-3.0.3
	>=dev-util/pkgconfig-0.20
	>=dev-libs/nss-3.12
	dev-libs/glib:2
	x11-libs/gtk+:2
	>=dev-libs/nspr-4.7.1
	media-fonts/corefonts
	dev-util/scons
"
RDEPEND="${DEPEND}"

S="${S}/src"

pkg

pkg_setup() {
	use amd64 && die "No 64bit support at this time!"
}

src_prepare() {

	cd ${S}/src
	einfo "Updating file_version_info_linux.h"
	sed -i -e "s,svn info,svn info ${EGCLIENT_STORE_DIR}/${EGCLIENT_PROJECT}/src," \
		chrome/tools/build/linux/version.sh || die
	cd ${S}/src/base
	../chrome/tools/build/linux/version.sh file_version_info_linux.h.version file_version_info_linux.h || die
	
	cd ${S}/src/build
	epatch ${FILESDIR}/disable_warnings.patch

	cd ${S}
	src/tools/gyp/gyp_dogfood src/build/all.gyp || die "gpy failed"

}

src_compile() {

	cd ${S}/src/chrome
	scons --mode=Release --site-dir=../site_scons ${MAKEOPTS} app || die "scons build failed"

}

src_install() {

	cd ${S}/src/sconsbuild/Release

	dodir /opt/google-chrome
	dodir /opt/google-chrome/locales
	dodir /opt/google-chrome/themes

	insinto /opt/google-chrome
	doins chrome.pak

	insinto /opt/google-chrome/locales
	doins -r locales/*

	insinto /opt/google-chrome/themes
	doins -r themes/*

	exeinto /opt/google-chrome
	doexe chrome
	dosym /opt/google-chrome/chrome /opt/bin/chrome	

	insinto /usr/share/applications
	doins ${FILESDIR}/google-chrome.desktop

	insinto /usr/share/applications
	doins ${FILESDIR}/google-chrome-icon.png

}
