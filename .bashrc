# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#figlet "`hostname` >"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Color Variables
c1='\[\033[0;30m\]'
C1='\[\033[1;30m\]'
c2='\[\033[0;31m\]'
C2='\[\033[1;31m\]'
c3='\[\033[0;32m\]'
C3='\[\033[1;32m\]'
c4='\[\033[0;33m\]'
C4='\[\033[1;33m\]'
c5='\[\033[0;34m\]'
C5='\[\033[1;34m\]'
c6='\[\033[0;35m\]'
C6='\[\033[1;35m\]'
c7='\[\033[0;36m\]'
C7='\[\033[1;36m\]'
c8='\[\033[0;37m\]'
C8='\[\033[1;37m\]'
NC='\[\033[0m\]'

# Prompt
if [ "`id -u`" -eq 0 ]; then
      PSS='#'
else
      PSS='$'
fi
PS1="$c2[$C8\u$c2@$C7\h $C6\W$c2]$C2\$PSS $NC"
#PS1="[\u@\h \W]\$PSS "
PS2="$C1^D$NC>"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lah'

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

. ~/scripts/alias_completion.sh

if [ -e $HOME/.bash_functions ]; then
  source $HOME/.bash_functions
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
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0
export KWIN_COMPOSE=X
export GPG_TTY=$(tty)

