# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

BASH_A=~/.aliases/bash
if [ -f $BASH_A ]; then
    . $BASH_A
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#figlet "`hostname` >"
export PATH=$PATH:~/.local/bin

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Color Variables
black='\[\033[0;30m\]'
BLACK='\[\033[1;30m\]'
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
blue='\[\033[0;34m\]'
BLUE='\[\033[1;34m\]'
magenta='\[\033[0;35m\]'
MAGENTA='\[\033[1;35m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
white='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
NC='\[\033[0m\]'

# Prompt
if [ "`id -u`" -eq 0 ]; then
    PSS='#'
else
    PSS='$'
fi
PS1="$red[$WHITE\u$red@$CYAN\h $magenta\W$red]$RED$PSS$NC "
#PS1="[\u@\h \W]\$PSS "
PS2="$C1>$NC"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
if command -v exa &> /dev/null; then
    alias ll='exa -blaH --git'
    alias ls=exa
else
    alias ll='ls -lah'
fi

# ripgrep
if command -v rg &> /dev/null; then
    alias grep=rg
fi

# bat
if command -v bat &> /dev/null; then
    alias cat=bat
fi

# python alias
alias python='python3'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -e ~/scripts/alias_completion.sh ]; then
    . ~/scripts/alias_completion.sh
fi

if [ -e ~/.bash_functions ]; then
  . ~/.bash_functions
fi

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-logi
#export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0
export KWIN_COMPOSE=X
export GPG_TTY=$(tty)
export EDITOR=vim
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_DIRS=/usr/local/share/:/usr/share/
