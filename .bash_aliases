# Private Aliases
if [ -f ~/.private_aliases ]; then
    . ~/.private_aliases
fi

# Public Aliases
# Cfg
## List
alias la='cat ~/.bash_aliases'
alias lp='cat ~/.private_aliases'
alias lb='cat ~/.bashrc'
#alias lp='cat ~/.bash_profile'
alias lf='cat ~/.bash_functions'
alias lssh='cat ~/.ssh/config'

## Grep
alias lag='cat ~/.bash_aliases | grep'
alias lpg='cat ~/.private_aliases | grep'
alias lbg='cat ~/.bashrc | grep'
alias lpg='cat ~/.bash_profile | grep'
alias lfg='cat ~/.bash_functions | grep'
alias lsshg='cat ~/.ssh/config | grep'

## Edit
alias ea='nano ~/.bash_aliases'
alias ep='nano ~/.private_aliases'
alias eb='nano ~/.bashrc'
#alias ep='nano ~/.bash_profile'
alias ef='nano ~/.bash_functions'
alias essh='nano ~/.ssh/config'

# Pkg
alias updt='u'
alias u='sudo apt update && sudo apt full-upgrade -y --auto-remove --fix-broken --fix-missing --fix-policy --show-progress && sudo apt autoclean'
alias inst='sudo apt install -y --auto-remove --fix-missing --fix-broken --fix-policy --show-progress --upgrade'
alias uinst='sudo apt purge -y --auto-remove --show-progress'

# Bash
alias r='fc -s'
alias cls='clear'
alias spkill='sudo pkill'
alias distro='uname -nrmo'
alias nf='neofetch --config ~/.config/neofetch/raymolinux.conf'
alias d='cd $homedir/Downloads'

# Grep
alias hg='history | grep'
alias pg='pstree | grep'
alias lg='ls | grep'
alias llg='ll | grep'

# File
alias led='find . -type d -empty'
alias guc="grep -v '^ *#'"
alias rel="sed -i '/^$/d'"
alias sn='sudo nano'
alias fown='sudo chown -R $(whoami) ~'
alias filecount='find . -type f | wc -l'
alias cpv='rsync -ah --info=progress2'
alias clsql='sudo rm -rf /root/.mysql_history'

# SysCtl
alias sctl='sudo systemctl'
alias uctl='systemctl --user'

# Net
alias m3r='youtube-dl -x -f bestaudio --audio-format mp3 -o "%(title)s.%(ext)s"'
alias m4r='youtube-dl -f bestvideo+bestaudio -o "%(title)s.%(ext)s"'
alias m4r1='youtube-dl -f best -o "%(title)s.%(ext)s"'
alias ipi='curl ifconfig.co'
alias imgbb='/home/raymo/scripts/imgbb.sh'
alias ds='dig +short'
alias dl='wget -np -mpE --convert-links -e robots=off -P .'
alias crawl='wget -r -e robots=off -np --spider'
alias wgetlist='while read -r url filename tail; do wget -O "$filename" "$url" || err=1; done <'

# Resume
alias ur='/home/raymo/scripts/updateresume.sh'
alias cr='cp $gitdir/raymo111.github.io/resume.pdf $homedir/Downloads/Resume - Raymond Li.pdf'

# Date
alias nicedate="date +'%F %T %Z'"
alias touchh='/homr/raymo/scripts/touch.sh'
