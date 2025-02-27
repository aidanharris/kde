# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PVCUT=$(ver_cut 1-2)
QTMIN=5.15.9
inherit ecm frameworks.kde.org

DESCRIPTION="Framework for converting units"

LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtnetwork-${QTMIN}:5
	=kde-frameworks/ki18n-${PVCUT}*:5
"
RDEPEND="${DEPEND}"

src_test() {
	local CMAKE_SKIP_TESTS=(
		# bug 623938 - needs internet connection
		convertertest
		# bug 808216 - needs internet connection
		categorytest
		# bug 808216 - unknown, reported upstream
		currencytableinittest
	)

	LC_NUMERIC="C" ecm_src_test # bug 694804
}
