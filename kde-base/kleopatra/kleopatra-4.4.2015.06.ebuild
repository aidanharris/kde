# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim"
KDE_HANDBOOK=optional
inherit kde4-meta

DESCRIPTION="Kleopatra - KDE X.509 key manager (noakonadi branch)"
KEYWORDS=""
IUSE="debug"

SRC_URI+=" http://dev.gentoo.org/~dilfridge/distfiles/${PN}-4.4.11.1-libassuan2.patch.bz2"

DEPEND="
	app-crypt/gpgme
	>=dev-libs/libassuan-2.0.0
	dev-libs/libgpg-error
	$(add_kdebase_dep kdepimlibs '' 4.6)
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

RESTRICT=test
# bug 399431

KMEXTRACTONLY="
	libkleo
"
KMLOADLIBS="libkleo"

PATCHES=(
	"${DISTDIR}/${PN}-4.4.11.1-libassuan2.patch.bz2"
	"${FILESDIR}/${PN}-4.4.2015.06-reenable.patch"
)

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/kwatchgnupg
		"
	fi

	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs=(
		-DWITH_QGPGME=ON
	)

	kde4-meta_src_configure
}
