# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# File locations
BASH_A=~/.aliases/bash
BASH_F=~/.bash_functions
A_COMPL=~/scripts/alias_completion.sh
GIT_COMP_DIR=/usr/share/git/completion
GIT_COMP_BASH=$GIT_COMP_DIR/git-completion.bash
GIT_COMP_PROMPT=$GIT_COMP_DIR/git-prompt.sh
BASH_BLESH=/usr/share/blesh/ble.sh 

export homedir=$HOME # For WSL where $HOME is the Linux home but I might want a Windows Home
export gitdir=$homedir/Git
export dldir=$homedir/Downloads
export scriptdir=$homedir/scripts
export rc=$homedir/raymocloud

# Misc vars
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0
export DISPLAY=:0
export GPG_TTY=$(tty)
export EDITOR=vim
export VISUAL=vim
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_DIRS=/usr/local/share/:/usr/share/
export PATH=$PATH:~/.local/bin:~/.local/share/gem/ruby/3.0.0/bin

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
if [[ $(locale charmap) == "UTF-8" ]]; then
	L1C=┌
	L2C=└
fi
if command -v lsb_release &> /dev/null; then
	DEB_VER="($(lsb_release -cs)) "
fi
if [ -f $GIT_COMP_PROMPT ]; then
	. $GIT_COMP_PROMPT
	export GIT_PS1_SHOWDIRTYSTATE=1
	export GIT_PS1_SHOWSTASHSTATE=1
	export GIT_PS1_SHOWUNTRACKEDFILES=1
	export GIT_PS1_SHOWUPSTREAM="auto"
	export GIT_PS1_SHOWCOLORHINTS=1
	export GIT_PS1_HIDE_IF_PWD_IGNORED=1
	GIT_PROMPT='$(__git_ps1)'
fi
if [ "`id -u`" -eq 0 ]; then
	PSS='#'
else
	PSS='$'
fi
PS1="$red$L1C[$WHITE\u$red@$CYAN\h $DEB_VER$magenta\w$red]$RED$yellow$GIT_PROMPT$NC\n$red$L2C$PSS$NC "
#PS1="[\u@\h \W]\$PSS "
PS2="$C1>$NC"

# Blesh

[ -f $BASH_A ] && . $BASH_A
[ -f $BASH_F ] && . $BASH_F

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
#export HISTFILE=~/.bash_eternal_history
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# If not running interactively, don't do anything else
case $- in
	*i*) ;;
	*) return;;
esac

#figlet "`hostname` >"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
	alias lll='\ls -lah'
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
	#export VISUAL=bat
fi

# stderred
#if [[ -f /usr/share/stderred/stderred.sh ]]; then
#	. /usr/share/stderred/stderred.sh
#fi

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

[ -f $A_COMPL ] && . $A_COMPL
[ -f $GIT_COMP_BASH ] && . $GIT_COMP_BASH

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Powerline
POWERLINE_ON=0
if [ $POWERLINE_ON == 1 ]; then
	PYTHON_USER_SITE=$(python -m site --user-site)
	PYTHON_GLOBAL_SITE=$(python -c 'import site; print(site.getsitepackages()[0])')
	if [ -d $PYTHON_USER_SITE/powerline ]; then
		POWERLINE_ROOT=$PYTHON_USER_SITE/powerline
	elif [ -d $PYTHON_GLOBAL_SITE/powerline ]; then
		POWERLINE_ROOT=$PYTHON_GLOBAL_SITE/powerline
	fi
	if [ -n $POWERLINE_ROOT ]; then
		POWERLINE_SH=$POWERLINE_ROOT/bindings/bash/powerline.sh
		if [ -f $POWERLINE_SH ]; then
			powerline-daemon -q
			POWERLINE_BASH_CONTINUATION=1
			POWERLINE_BASH_SELECT=1
			. $POWERLINE_SH
		fi
	fi
fi

# Histfile check
[[ "$(sed '2q;d' $HISTFILE)" == *_START_ ]] || echo -e "\e[31mHISTFILE CUT SHORT\e[m"

# Ble.sh
[[ $- == *i* ]] && [ -f $BASH_BLESH ] && source "$BASH_BLESH" --rcfile "$HOME/.blerc"
[ -f $BASH_BLESH ] && [[ ${BLE_VERSION-} ]] && ble-attach
