#!/bin/bash

shopt -s expand_aliases

# paste command
alias paste='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -sta "Add-Type -AssemblyName System.Windows.Forms;if ([Windows.Forms.Clipboard]::ContainsImage()) {[Windows.Forms.Clipboard]::GetImage().Save(\"${winpath}\", [System.Drawing.Imaging.ImageFormat]::Png) }"' # winpath is the var getting copied
#alias paste='xclip -selection clipboard -o $path' # path is the var getting copied

# copy command
function copy { echo -ne "$1" | clip.exe; }
#alias copy='xclip -selection c'

path="/tmp/img/"
ext="png"
user="raymo"

mkdir -p $path
read -p "filename >" name
if [[ $name == *"/"* ]]; then
  echo "Filename cannot contain slashes for your safety, exiting..."
  exit
fi
hash wslpath && winpath="$(wslpath -m $path)/$name.$ext"
path="$path$name.$ext"
paste
#file $path # sanity check
scp $path "$user@csclub.uwaterloo.ca:www/"
rm $path
url="https://csclub.uwaterloo.ca/~$user/$name.$ext"
copy $url
echo "Done, url ($url) copied!"
