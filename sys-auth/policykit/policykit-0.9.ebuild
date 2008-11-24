# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/policykit/policykit-0.6.ebuild,v 1.6 2008/01/25 19:09:40 corsair Exp $

inherit autotools bash-completion eutils multilib pam

MY_PN="PolicyKit"

DESCRIPTION="Policy framework for controlling privileges for system-wide services"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit"
SRC_URI="http://hal.freedesktop.org/releases/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"
IUSE="bash-completion doc pam selinux zsh-completion"

RDEPEND=">=dev-libs/glib-2.6
		 >=dev-libs/dbus-glib-0.73
		 dev-libs/expat
		 pam? ( virtual/pam )
		 selinux? ( sys-libs/libselinux )"
DEPEND="${RDEPEND}
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
		>=dev-util/pkgconfig-0.18
		>=dev-util/intltool-0.36
		>=dev-util/gtk-doc-am-1.10-r1
		doc? ( >=dev-util/gtk-doc-1.10 )"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	enewgroup polkituser || die "failed to create group"
	enewuser polkituser -1 "-1" /dev/null polkituser || die "failed to create user"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-0.7-completions.patch"
	eautoreconf
}

src_compile() {
	local authdb=

	if use pam ; then
		authdb="--with-authdb=default --with-authfw=pam --with-pam-module-dir=$(getpam_mod_dir)"
	else
		authdb="--with-authdb=dummy --with-authfw=none"
	fi

	econf ${authdb} \
		--without-bash-completion \
		--without-zsh-completion \
		--enable-man-pages \
		--with-os-type=gentoo \
		--with-polkit-user=polkituser \
		--with-polkit-group=polkituser \
		$(use_enable doc gtk-doc) \
		$(use_enable selinux) \
		--localstatedir=/var
	# won't install with tests
	#	$(use_enable test tests) \
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc NEWS README AUTHORS ChangeLog

	if use bash-completion; then
		dobashcompletion "${S}/tools/polkit-bash-completion.sh"
	fi

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins "${S}/tools/_polkit" || die
		doins "${S}/tools/_polkit_auth" || die
		doins "${S}/tools/_polkit_action" || die
	fi

	einfo "Installing basic PolicyKit.conf"
	insinto /etc/PolicyKit
	doins "${FILESDIR}"/PolicyKit.conf
	# Need to keep a few directories around...

	diropts -m0770
	keepdir /var/run/PolicyKit
	keepdir /var/lib/PolicyKit
}
