# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

GTK_SHARP_MODULE="gnome"
GTK_SHARP_MODULE_DEPS="art"
GTK_SHARP_REQUIRED_VERSION="2.12"

inherit gtk-sharp-module

SLOT="2"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
		>=gnome-base/gconf-2.20
		=dev-dotnet/glade-sharp-${GTK_SHARP_REQUIRED_VERSION}*
		=dev-dotnet/gnome-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*"

src_unpack() {
	gtk-sharp-module_src_unpack

	# The makefile for GConf.PropertyEditors references two dll's which will
	# not be built in our case because of the splitting of gnome-sharp;
	# reference their system-installed counterparts instead.
	# TODO: Should this be in the eclass? If no, the other fix for gconf-sharp
	# in the eclass should be moved here as well.
	sed -i -e "s:\$(top_builddir)/art/art-sharp.dll:${GTK_SHARP_LIB_DIR}/art-sharp.dll:" \
			-e "s:\$(top_builddir)/gnome/gnome-sharp.dll:${GTK_SHARP_LIB_DIR}/gnome-sharp.dll:" \
			${S}/gconf/GConf.PropertyEditors/Makefile.in || die "sed failed"
}
