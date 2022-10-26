#!/bin/bash
if [ -z "$1" ]
then
	read -rp "Movie name: " movie
else
	movie="$*"
fi
echo "$movie"
res=$(curl -s "https://loadsubs.net/search.php?search=${movie// /+}" | grep -m 1 /movies/)
res=${res#*/movies/}
res=$(echo "$res" | cut -d'"' -f 1)
res=${res%-download*}
url="https://loadsubs.net/movies/download.php?file=$res-en1.srt"
echo "URL: $url"
wget "$url" -O "$res"
