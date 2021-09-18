function cl {
	DIR="$*";
	# if no DIR given, go home
	if [ $# -lt 1 ]; then
		DIR=~;
	fi;
	builtin cd "${DIR}" && ls --color=auto
}

function rotatepdfcw {
	pdftk $1 cat 1-endeast output $2
}

function rotatepdfccw {
	pdftk $1 cat 1-endwest output $2
}

function formfind {
	tmp=$(mktemp)
	wget $1 -O "$tmp"
	perl $scriptdir/formfind.pl < "$tmp"
	rm "$tmp"
}

function confirm {
	# call with a prompt string or use a default
	read -r -p "${1:-Are you sure? [y/N]} " response
	case "$response" in
		[yY][eE][sS]|[yY])
		true
			;;
		*)
			false
			;;
	esac
}

# Remove offending host from ssh known hosts
function fssh {
	sed -i "$1d" ~/.ssh/known_hosts
}

function aurcommit {
        MSG=$*
        if [[ -z "$1" ]]; then
                read -p "Message: " MSG
        fi
        updpkgsums
        makepkg --printsrcinfo > .SRCINFO
        git add PKGBUILD .SRCINFO
        namcap PKGBUILD
        git commit -m "$MSG"
}

# Curecoin worth
function cure {
        r==$(curl -s https://chainz.cryptoid.info/cure/address.dws?BLHuRzniSzyzvfaDEqCeXKPsNXLRLZw9p2.htm | grep with)
        r=${r#*with }
        r=${r%</small*}
        r=${r//<small>/}
        echo "$r CURE"
        echo "x=$r*$(curl -sX GET https://rest.coinapi.io/v1/exchangerate/CURE/CAD -H "X-CoinAPI-Key:BAAB8A8A-8B5C-4F8C-8AC3-7923736ECDC7" |jq -r .rate);if(x<1)print 0; x"|bc
}

# Git rename branch
function grb {
	git checkout $1
	git branch -m $2
	git push origin -u $2
	git push origin --delete $1
}

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
