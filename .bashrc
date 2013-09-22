# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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
xterm* | rxvt* | eterm-color | screen-256color )
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="${debian_chroot:+($debian_chroot)}[\[\033[1;32m\]\A\[\033[00m\]] \[\033[36m\]\w\[\033[00m\] \[\033[01;31m\]\$\[\033[00m\] "
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


### customization

# force 256 color gnome-terminal terminfo
#if [[ TERM=="xterm" && COLORTERM==gnome* ]]; then
#    export TERM=”gnome-256color”
#fi

TERM=xterm-256color
export TERM
#[ -z "$TMUX" ] && export TERM=xterm-256color

# set my local directory
MY_LOCAL_DIR=~/local

# set my local bin
PATH=$PATH:${MY_LOCAL_DIR}/bin

# set environment virables to add include path for gcc/g++
C_INCLUDE_PATH=${MY_LOCAL_DIR}/include
export C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=${C_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH


# append include path for apue/unp header
APUE_ROOT=~/rep/program/linux/apue/src
#UNP_ROOT=~/rep/program/unp
C_INCLUDE_PATH=${C_INCLUDE_PATH}:${APUE_ROOT}/include
#\:${UNP_ROOT}/include
CPLUS_INCLUDE_PATH=${C_INCLUDE_PATH}

#LDLIBRARIES=${LDLIBRARIES}:${APUE_ROOT}/lib

# set makefile template file path
MAKE_TEMPLATE_DIR=${MY_LOCAL_DIR}/make_template
export MAKE_TEMPLATE_DIR

# source helper functions
source ${MY_LOCAL_DIR}/bin/helper_functions.sh

# set environment variable EDITOR for crontab and mercurial
EDITOR=vim
export EDITOR

# alias settings
alias em='env LC_CTYPE=zh_CN.utf8 emacs -nw --debug-init'
alias sc='screen'
alias ipy='ipython'

# set language
LANGUAGE=en_US:en:zh_CN:zh
export LANGUAGE
LANG=en_US.UTF-8
export LANG
LC_ALL=en_US.UTF-8
export LC_ALL

# temporary file directory
# it's ok that we don't set it, because in gnu libc P_tmpdir is set to '/tmp'
# refer to <stdio.h>
TMPDIR=/tmp

# add module path for python
if [ -z PYTHONPATH ]; then
    export PYTHONPATH=${HOME}/local/py_module
else
    export PYTHONPATH=${HOME}/local/py_module:$PYTHONPATH
fi

# set environment for TIJ4
TIJ4_SRC_HOME=~/program/java/tij4/TIJ4-code/
CLASSPATH=$CLASSPATH:$TIJ4_SRC_HOME


# set PATH for mit-scheme
# PATH=${PATH}:/opt/mit-scheme/bin
# export PATH

# turn off system bell on X
#xset -b


## python startup script
export PYTHONSTARTUP=~/.pythonstartup
