# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils distutils

DESCRIPTION="model-view-controller (MVC) implementation for pygtk"
HOMEPAGE="http://pygtkmvc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
	dev-lang/python
	dev-python/pygtk"

RDEPEND="${DEPEND}"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_python_version

	site_pkgs="$(python_get_sitedir)"
	export PYTHONPATH="${PYTHONPATH}:${D}/${site_pkgs}"
	dodir ${site_pkgs}

	distutils_src_install
}
