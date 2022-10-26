#!/bin/bash
if [ -z "$1" ]
then
	read -rp "Movie name: " movie
else
	movie="$*"
fi
res=$(curl -s "https://www.yifysubtitles.com/search?q=${movie// /%20}" | grep -m 1 /movie-imdb/)
res=${res#*/movie-imdb/}
res=${res%\" itemprop=\"url\"*}
url="https://www.yifysubtitles.com/movie-imdb/$res"
echo "URL: $url"
link=$(curl -s "$url" | grep -m 1 English)
link=$(echo "${link#*English</span></td><td><a href=\"/}" | cut -f1 -d"\"")
google-chrome-stable --new-window &
sleep 2
xdotool type "https://www.yifysubtitles.com/${link}.zip"
xdotool key Return
sleep 4
xdotool key Tab Tab Tab Home Down Down Return
sleep 3
xdotool key Ctrl+W
link=${link#*/}
# shellcheck disable=SC2154
unzip "$dldir/${link}".zip
rm "$dldir/${link}".zip
#echo "https://www.yifysubtitles.com/${link}.zip" | xclip -selection c
#echo "Link copied to clipboard!"
