#!/bin/bash

update() {
	sed -iE "s/pkgver=.*/pkgver=$1/;s/pkgrel=.*/pkgrel=1/" PKGBUILD
	updpkgsums
    makepkg --printsrcinfo > .SRCINFO
    git add PKGBUILD .SRCINFO
    namcap PKGBUILD
    git commit -m "Bump version to $1"
	git push
}

stable=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE")
beta=$(curl -s "https://chromedriver.chromium.org/" | grep -oP "(?<=ChromeDriver )\d{2,3}(\.\d+){3}" | grep -v "$stable")

cd /home/raymo/AUR/chromedriver || exit
git pull
grep "$stable" PKGBUILD || update "$stable"
cd /home/raymo/AUR/chromedriver-beta || exit
git pull
grep "$beta" PKGBUILD || update "$beta"
