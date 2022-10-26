#!/bin/bash

shopt -s expand_aliases

# paste command
# alias paste='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -sta "Add-Type -AssemblyName System.Windows.Forms;if ([Windows.Forms.Clipboard]::ContainsImage()) {[Windows.Forms.Clipboard]::GetImage().Save(\"${winpath}\", [System.Drawing.Imaging.ImageFormat]::Png) }"' # winpath is the var getting copied
alias paste='xclip -selection clipboard -o > $path' # path is the var getting copied

# copy command
function copy { echo -ne "$1" | clip.exe; }
#alias copy='xclip -selection c'

path="/tmp/img/"
ext="png"
user="r389li"

mkdir -p $path
name=$1
# shellcheck disable=SC2162
[ -z "$name" ] && read -p "filename >" name
if [[ $name == *"/"* ]]; then
	echo "Error: Filename $($name) contains slashes."
	exit 1
fi
# shellcheck disable=SC2034
hash wslpath && winpath="$(wslpath -m $path)/$name.$ext"
path="$path$name.$ext"
paste
#file $path # sanity check
scp "$path" "$user@csclub.uwaterloo.ca:www/" || exit 1
rm "$path" || echo "Error: Failed to remove $($path)."
url="https://csclub.uwaterloo.ca/~$user/$name.$ext"
copy "$url"
echo "Done, url ($url) copied!"
