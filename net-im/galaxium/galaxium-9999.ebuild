# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils mono

ESVN_REPO_URI="http://galaxium.googlecode.com/svn/trunk/"
ESVN_PROJECT="galaxium-read-only"

DESCRIPTION="Multi-Protocol Instant Messenger"
HOMEPAGE="http://code.google.com/p/galaxium/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="adium gecko msn webkit irc gadu yahoo aim jabber gnome"

DEPEND=">=dev-lang/mono-1.2.4
		>=dev-dotnet/mono-addins-0.3
		>=dev-dotnet/gtk-sharp-2.10.2
        webkit? ( >=dev-dotnet/webkit-sharp-0.2 )
		gecko? ( dev-dotnet/gecko-sharp ) 
		dev-dotnet/libanculus-sharp"
RDEPEND="${DEPEND}
		media-libs/gstreamer
		x86? ( media-libs/swfdec )"

pkg_setup() {

		ewarn "This is a LIVE SVN ebuild."
		ewarn "That means there are NO promises it will work."
		ewarn "If you want to report bugs, go to http://code.google.com/p/galaxium/issues/list"

}

src_compile() {

	! use adium &&	myconf="${myconf} --disable-adium"

	! use msn && myconf="${myconf} --disable-msn"

	use gecko && myconf="${myconf} --enable-gecko"
	
	! use webkit myconf="${myconf} --disable-webkit"

	! use irc && myconf="${myconf} --disable-irc"

	use aim && myconf="${myconf} --enable-aim"

	! use jabber && myconf="${myconf} --disable-xmpp"

	use yahoo && myconf="${myconf} --enable-yahoo"

	! use gadu && myconf="${myconf} --disable-gadugadu"

	use gnome && myconf="${myconf} --enable-gnome"

	cd ${WORKDIR}/${P} && /bin/sh ${WORKDIR}/${P}/autogen.sh ${myconf} --prefix=/usr

	emake || die "emake failed"
}

src_install() {

	emake DESTDIR="${D}" install || die "Install failed"

}
