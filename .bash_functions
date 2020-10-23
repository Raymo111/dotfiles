function cl() {
	DIR="$*";
	# if no DIR given, go home
	if [ $# -lt 1 ]; then
		DIR=$HOME;
	fi;
	builtin cd "${DIR}" && ls --color=auto
}

function rotatepdfcw() {
	pdftk $1 cat 1-endeast output $2
}
function rotatepdfacw() {
	pdftk $1 cat 1-endwest output $2
}
function findform() {
	wget $1 -O "/tmp/page.html"
	perl /usr/lib/ipetitions-bot/formfind.pl < /tmp/page.html
	rm /tmp/page.html
}
