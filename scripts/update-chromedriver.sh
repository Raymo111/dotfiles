#!/bin/bash -x

update() {
	echo "updating"
	sed -iE "s/pkgver=.*/pkgver=$1/;s/pkgrel=.*/pkgrel=1/" PKGBUILD
	updpkgsums
    makepkg --printsrcinfo > .SRCINFO
    git add PKGBUILD .SRCINFO
    namcap PKGBUILD
    git commit -m "Bump version to $1"
	git push
}

stable=$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | jq -r .channels.Stable.version)
beta=$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | jq -r .channels.Beta.version)
stable_url=$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | jq -r '.channels.Stable.downloads.chromedriver | .[] | select(.platform == "linux64").url') # | sed "s/${stable}/\$\{stable\}/;s/chromedriver/\$\{pkgname\}/")
beta_url=$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | jq -r '.channels.Beta.downloads.chromedriver | .[] | select(.platform == "linux64").url') # | sed "s/${beta}/\$\{beta\}/")

if [[ $stable_url =~ https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/.*/linux64/chromedriver-linux64.zip ]]; then
	echo "Stable url ok"
else
	echo "Stable url changed"
	exit 1
fi

if [[ $beta_url =~ https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/.*/linux64/chromedriver-linux64.zip ]]; then
	echo "Beta url ok"
else
	echo "Beta url changed"
	exit 1
fi

cd /home/raymo/AUR/chromedriver || exit
git pull
echo "Checking stable"
grep "$stable" PKGBUILD || update "$stable"
cd /home/raymo/AUR/chromedriver-beta || exit
git pull
echo "Checking beta"
grep "$beta" PKGBUILD || update "$beta"
