# ~.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# Then extra stuff to append history from all tmux windows:
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more ls aliases
alias ll='ls -lFh'
alias la='ls -lFhA'
alias l='ls -CF'
# alias vim="nvim"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# read ~/.dircolors
d=.dircolors
test -r $d && eval "$(dircolors $d)"

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
. /etc/bash_completion

# Essential line to get tmux to work with solarized:
export TERM=screen-256color-bce

# Nvim-r-plugin requires its own line in .vimrc to achieve this
alias R='R --no-save --quiet'
alias sudo='sudo ' # ensures that sudo R loads .Rprofile

# shell promopt (31m = red, 32m = green)
export PS1='\[\e[1;32m\]\w\$\[\e[0m\] '

# open man pages with vim
man() {
    /usr/bin/man $* | \
    col -b | \
    vim -R -c 'set ft=man nomod nolist' -
}

# aliases
alias up='cd ..'
alias desktop='cd ~/Desktop'
alias doc='cd ~/Documents'
alias down='cd ~/Downloads'
alias replaceAllSpaces='for file in *; do mv "$file" `echo $file | tr " " "_"` ; done'
alias generatePassword='apg -m 20 -x 1 -M SNCL -a 1 -n 1'
alias histg='history | grep'
#dump clipboard to file
alias dclip='xclip -o > clipboard.txt'
alias t='todo-txt -t -d ~/.todo-txt/config'
alias rupdate='echo "update.packages (ask = FALSE)" | R --no-save -q'
alias lll='du -chs *'
alias g='grep'
alias gi='grep -i'

function cpc {
if [ -z "$1" ]; then
    echo "Usage: mvc <file_name> <directory_name>"
else
    if [ -f $1 ] ; then
        mkdir -p $2
        cp $1 $2 && cd $2
    else
        cp $1 $2 && cd $2
    fi
fi
}

function mvc {
if [ -z "$1" ]; then
    echo "Usage: mvc <file_name> <directory_name>"
else
    if [ -f $1 ] ; then
        mkdir -p $2
        mv $1 $2 && cd $2
    else
        mv $1 $2 && cd $2
    fi
fi
}

function mkc {
if [ -z "$1" ]; then
    echo "Usage: mkc <directory_name>"
else
    mkdir $1 && cd $1
fi
}

function run {
if [ -z "$1" ]; then
    echo "Usage: run <file_name>"
else
    if [ -f $1 ] ; then
        xdg-open $1 &> /dev/null
    else
        echo "$1 - file does not exist"
    fi
fi
}

function extract {
if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ./$1    ;;
          *.tar.gz)    tar xvzf ./$1    ;;
          *.tar.xz)    tar xvJf ./$1    ;;
          *.lzma)      unlzma ./$1      ;;
          *.bz2)       bunzip2 ./$1     ;;
          *.rar)       unrar x -ad ./$1 ;;
          *.gz)        gunzip ./$1      ;;
          *.tar)       tar xvf ./$1     ;;
          *.tbz2)      tar xvjf ./$1    ;;
          *.tgz)       tar xvzf ./$1    ;;
          *.zip)       unzip ./$1       ;;
          *.Z)         uncompress ./$1  ;;
          *.7z)        7z x ./$1        ;;
          *.xz)        unxz ./$1        ;;
          *.exe)       cabextract ./$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

function github_update_fork {
if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: github_update_fork username/repository"
 else
    git remote add upstream https://github.com/$1.git
    git fetch upstream
    git checkout master
    git rebase upstream/master
fi
}

function getipaddress {
    ip route get 8.8.8.8 | awk '{print $NF; exit}'
}
