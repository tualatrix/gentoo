# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

MY_VER="1.0.0-860"
MY_PN="Songbird"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="A multimedia player, inspired by iTunes"
HOMEPAGE="http://www.songbirdnest.com/"
SRC_URI="amd64? ( http://download.songbirdnest.com/installer/linux/x86_64/${MY_PN}_${MY_VER}_linux-x86_64.tar.gz  )
	x86? ( http://download.songbirdnest.com/installer/linux/i686/${MY_PN}_${MY_VER}_linux-i686.tar.gz ) "
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa oss esd ogg flac faac fad musepack ugly theora speex ffmpeg gnome jpeg"
RESTRICT="strip"
RDEPEND="${DEPEND}
	alsa? ( media-plugins/gst-plugins-alsa )
	oss?  ( media-plugins/gst-plugins-oss )
	esd?  ( media-plugins/gst-plugins-esd )
	ogg? ( media-plugins/gst-plugins-ogg
			media-plugins/gst-plugins-vorbis )
	gnome? ( media-plugins/gst-plugins-gconf
			media-plugins/gst-plugins-gnomevfs )
	flac? ( media-plugins/gst-plugins-flac )
	faac? ( media-plugins/gst-plugins-faac )
	faad? ( media-plugins/gst-plugins-faad )
	ugly?  ( media-libs/gst-plugins-ugly )
	musepack? ( media-plugins/gst-plugins-musepack )
	theora? ( media-plugins/gst-plugins-theora )
	speex? ( media-plugins/gst-plugins-speex )
	ffmpeg? ( media-plugins/gst-plugins-ffmpeg )
	jpeg? ( media-plugins/gst-plugins-jpeg )"
DEPEND="${RDEPEND}
	x11-libs/libXdmcp
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXext
	x11-libs/libX11
	dev-libs/liboil
	media-libs/gstreamer
	media-libs/gst-plugins-base
	media-plugins/gst-plugins-x
	media-plugins/gst-plugins-xvideo
	media-plugins/gst-plugins-lame
	media-plugins/gst-plugins-mpeg2dec
	media-plugins/gst-plugins-mad
	>=net-misc/neon-0.26.4
	media-plugins/gst-plugins-neon
	>=sys-libs/glibc-2.3.2
	>=x11-libs/gtk+-2.0.0
	>=virtual/xft-7.0
	>=virtual/libstdc++-3.3
	x11-libs/pango"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PN}-1.0.0-symlink.patch"
}

src_install() {
	insinto /opt/songbird
	doins -r *
	fperms 755 /opt/songbird/songbird
	fperms 755 /opt/songbird/songbird-bin
	dosym /opt/songbird/songbird /opt/bin/songbird-bin

	newicon "${S}"/chrome/icons/default/default.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}.xpm "AudioVideo;Player"
}

pkg_postinst() {
	echo
	ewarn "Songbird is still under development!"
	ewarn "This ebuild is not supported by Gentoo, so"
	ewarn "please do not send any bugs at Gentoo's bugzilla."
	einfo "If you need help, find it there:"
	einfo "http://tnij.org/songbird-community"
	einfo "or"
	einfo "http://tnij.org/songbird-at-fgo"
	einfo ""
	einfo "If You need other music/video plugins, look at"
	einfo "Your portage tree into media-plugins/gst-plugins-*,"
	einfo "but remember, that not all plugins are supported yet."
	einfo ""
	einfo "If You don't want too much deps on it package,"
	einfo "disable gnome support"
	echo
}
