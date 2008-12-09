# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-workstation/vmware-workstation-6.5.0.118166.ebuild,v 1.2 2008/11/09 21:41:32 ikelos Exp $

inherit eutils versionator fdo-mime gnome2-utils

MY_PN="VMware-Workstation-$(replace_version_separator 3 - $PV)"

DESCRIPTION="Emulate a complete PC on your PC without the usual performance overhead of most emulators"
HOMEPAGE="http://www.vmware.com/products/desktop/ws_features.html"
SRC_URI="
	x86? (
		mirror://vmware/software/wkst/${MY_PN}.i386.bundle
		http://download.softpedia.ro/linux/${MY_PN}.i386.bundle )
	amd64? (
		mirror://vmware/software/wkst/${MY_PN}.x86_64.bundle
		http://download.softpedia.ro/linux/${MY_PN}.x86_64.bundle )
	"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
RESTRICT="strip fetch binchecks"
PROPERTIES="interactive"

# vmware-workstation should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
DEPEND=">=dev-lang/python-2.5
		dev-python/lxml"
RDEPEND="sys-libs/glibc
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXi
	x11-libs/libview
	dev-cpp/libsexymm
	dev-cpp/cairomm
	dev-cpp/libgnomecanvasmm
	virtual/xft
	!app-emulation/vmware-player
	!app-emulation/vmware-server
	~app-emulation/vmware-modules-1.0.0.23
	!<app-emulation/vmware-modules-1.0.0.23
	!>=app-emulation/vmware-modules-1.0.0.24
	sys-apps/pciutils"

S=${WORKDIR}/vmware-distrib
VM_INSTALL_DIR="/opt/vmware/workstation"

pkg_setup() {
	if use x86; then
		MY_P="${MY_PN}.i386"
	elif use amd64; then
		MY_P="${MY_PN}.x86_64"
	fi

	if ! built_with_use ">=dev-cpp/gtkmm-2.4" accessibility ; then
		eerror "Rebuild dev-cpp/gtkmm with USE=\"accessibility\""
		die "VMware workstation only works with gtkmm built with USE=\"accessibility\"."
	fi

	if ! built_with_use -a '>=dev-lang/python-2.5' sqlite ncurses; then
		eerror "You need to build dev-lang/python with \"sqlite ncurses\" USE flags!"
		die "Please rebuild dev-lang/python with sqlite and ncurses USE flags!"
	fi

	if [ "$(python -c "import curses; curses.setupterm(); print curses.tigetstr('hpa')")" == "None" ]; then
		die "Please emerge this package using a different terminal (e.g. not within screen)."
	fi
}

pkg_nofetch() {
	if use x86; then
		MY_P="${MY_PN}.i386"
	elif use amd64; then
		MY_P="${MY_PN}.x86_64"
	fi

	einfo "Please download the ${MY_P}.bundle from ${HOMEPAGE}"
}

src_unpack() {
	# Unbundle the bundle
	cp "${FILESDIR}"/helpers/* "${WORKDIR}"
	chmod a+x "${WORKDIR}"/*.sh
	"${WORKDIR}"/unbundler.sh "${DISTDIR}/${MY_P}".bundle

	# Patch up the installer
	epatch "${FILESDIR}/${P}-installer.patch"

	mkdir "${WORKDIR}/vmware-confdir"
}

src_install() {
	dodir /etc/init.d

	#Run the installer
	local INSTALLER="${WORKDIR}/payload/install/vmware-installer"
	local PYOPTS="-W ignore::DeprecationWarning"
	export VMWARE_SKIP_NETWORKING="true"
	python ${PYOPTS} "${INSTALLER}/vmware-installer.py" \
		--set-setting vmware-installer.libconf "${INSTALLER}/lib/libconf" \
		--set-setting initdir "${T}" \
		--set-setting initscriptdir "${D}/etc/init.d" \
		--set-setting prefix "${D}${VM_INSTALL_DIR}" \
		--set-setting sysconfdir "${D}/etc" \
		--install-component "${INSTALLER}" \
		--install-bundle "${DISTDIR}/${MY_P}.bundle" \
		--console --required

	rm -fr "${D}${VM_INSTALL_DIR}/lib/vmware/modules/binary"

	if [ ! -e "${WORKDIR}"/vmware-confdir/bootstrap ]; then
		eerror "VMware installation seems to have rolled back."
		eerror "Please include the contents of ${WORKDIR}/vmware-installer.log"
		eerror "in any bug reports you file."
		die "VMware installation rolled back."
	fi

	# Redirect all the ${D} paths to / paths"
	sed -i -e "s:${D}::" "${WORKDIR}"/vmware-confdir/bootstrap

	# Fix up icons/mime/desktop handlers
	dodir /usr/share/
	mv "${D}${VM_INSTALL_DIR}"/share/applications "${D}"/usr/share/
	rm -f "${D}${VM_INSTALL_DIR}"/share/icons/hicolor/{icon-theme.cache,index.theme}
	mv "${D}${VM_INSTALL_DIR}"/share/icons "${D}"/usr/share/
	dodir /usr/share/mime
	mv "${D}${VM_INSTALL_DIR}"/share/mime/packages "${D}"/usr/share/mime
	sed -i -e "s:${D}::" "${D}"/usr/share/applications/*.desktop

	# Copy across the temporary /etc/vmware directory
	dodir /etc/vmware/init.d
	cp -r "${WORKDIR}"/vmware-confdir/* "${D}/etc/vmware"
	mv "${D}"/etc/init.d/* "${D}/etc/vmware/init.d"
	newinitd "${FILESDIR}/${PN}"-6.5.rc vmware
	touch "${D}"/etc/vmware/networking

	# Setup the path environment
	insinto /etc/env.d
	doins "${FILESDIR}/90${PN}"

	# Fix some paths to allow included gtk to work
	for i in 	"/etc/pango/pangorc" 			\
				"/etc/pango/pango.modules"		\
				"/etc/gtk-2.0/gtk.immodules"	\
				"/etc/gtk-2.0/gdk-pixbuf.loaders" ; do
		sed -i -e "s:${D}::" "${D}${VM_INSTALL_DIR}"/lib/vmware/libconf${i} ;
		sed -i -e "s:${D}::" "${D}${VM_INSTALL_DIR}"/lib/vmware/installer/lib/libconf${i} ;
	done

	# No idea why this happens, but it seems to happen all the time
	ewarn "The following installation segment takes a *very* long time."
	ewarn "Please be patient."
}

pkg_config() {
	${VM_INSTALL_DIR}/bin/vmware-networks --postinstall ${PN},old,new
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update

	ewarn "Before you can use vmware-player, you must configure a default
	network setup."
	ewarn "You can do this by running 'emerge --config ${PN}'."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
