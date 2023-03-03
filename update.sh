#!/bin/sh
set -e
cd -P -- "$(dirname -- "$0")"

VERSION="${1:?Version not specified}"

if [ "$VERSION" = "dev" ]; then
    VERSION="dev"
    URL="git+https://github.com/FWDekker/mommy.git#branch=dev"
    REL="$(grep "pkgrel=" PKGBUILD)"
    REL="${REL##*=}"
else
    VERSION="${VERSION##v}"
    URL="git+https://github.com/FWDekker/mommy.git#tag=v\$pkgver"
    REL="1"
fi

sed -i -E "s|pkgver=.*|pkgver=$VERSION|; s|pkgrel=.*|pkgrel=$REL|; s|source=.*|source=(\"$URL\")|;" PKGBUILD
makepkg --printsrcinfo > .SRCINFO
