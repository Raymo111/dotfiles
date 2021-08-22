# Private Aliases
if [ -f ~/.private_aliases ]; then
    . ~/.private_aliases
fi

# Public Aliases
# Cfg
## List
alias la='cat ~/.bash_aliases'
alias lp='cat ~/.private_aliases'
alias lar='cat ~/.arch_aliases'
#alias lp='cat ~/.bash_profile'
alias lb='cat ~/.bashrc'
alias lf='cat ~/.bash_functions'
alias lssh='cat ~/.ssh/config'

## Grep
alias lag='cat ~/.bash_aliases | grep -i'
alias lpg='cat ~/.private_aliases | grep -i'
alias lar='cat ~/.arch_aliases | grep -i'
alias lbg='cat ~/.bashrc | grep -i'
alias lfg='cat ~/.bash_functions | grep -i'
alias lsshg='cat ~/.ssh/config | grep -i'

## Edit
alias ea='vim ~/.bash_aliases'
alias ep='vim ~/.private_aliases'
alias ear='vim ~/.arch_aliases'
alias eb='vim ~/.bashrc'
#alias ep='vim ~/.bash_profile'
alias ef='vim ~/.bash_functions'
alias essh='vim ~/.ssh/config'

## Update
alias ua='source ~/.bash_aliases'
alias ub='source ~/.bashrc'
#alias up='source ~/.bash_profile'
alias uf='source ~/.bash_functions'

# Pkg
alias u='updt'
alias i='inst'
alias ui='uinst'
alias updt='sudo apt update && sudo apt full-upgrade -y --auto-remove --fix-broken --fix-missing --fix-policy --show-progress && sudo apt autoclean'
alias inst='sudo apt install -y --auto-remove --fix-missing --fix-broken --fix-policy --show-progress --upgrade'
alias uinst='sudo apt purge -y --auto-remove --show-progress'

# Bash
alias r='fc -s'
alias cls='clear'
alias stealth='set +o history'
alias spkill='sudo pkill'
alias distro='uname -nrmo'
alias nf='neofetch'
alias d='cd $homedir/Downloads'
#alias diff='diff --strip-trailing-cr'
alias py='python3'

# Grep
alias hg='history | grep'
alias pg='pstree | grep'
alias lg='ls | grep'
alias llg='ll | grep'

# File
alias led='find . -type d -empty' # List empty directories
alias guc="grep -v '^ *#'" # Grep uncommented lines
alias rel="sed -i '/^$/d'" # Remove empty lines
alias sv='sudo vim'
alias fown='sudo chown -R $(whoami) ~'
alias filecount='find . -type f | wc -l'
alias cpv='rsync -ah --info=progress2'
alias clsql='sudo rm -rf /root/.mysql_history'
alias findcrlf='find . -not -type d -exec file "{}" ";" | grep CRLF'

# SysCtl
alias sctl='sudo systemctl'
alias uctl='systemctl --user'

# Net
alias m3r='youtube-dl -x -f bestaudio --audio-format mp3 -o "%(title)s.%(ext)s"'
alias m4r='youtube-dl -o "%(title)s.%(ext)s"'
alias ipi='curl -s ifconfig.co'
alias ds='dig +short'
alias dl='wget -r -np -p -E --convert-links -e robots=off -P .'
alias crawl='wget -r -e robots=off -np --spider'
alias wgetlist='while read -r url filename tail; do wget -O "$filename" "$url" || err=1; done <'

# Date
alias nicedate="date +'%F %T %Z'"
alias touchh='/home/raymo/scripts/touch.sh'

# CTF
alias rhex='head -c 8 /dev/urandom | xxd -ps'

# Arch aliases (overwriting default ubuntu ones)
if [ -f ~/.arch_aliases ]; then
    . ~/.arch_aliases
fi
