# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# configuracion para el scribbler
# export PYTHONPATH=$PYTHONPATH:~/scribbler/myro-2.9.1

# Consola de cakePHP
# export PATH="$PATH:/var/www/cakephp/lib/Cake/Console/"

#source /opt/ros/fuerte/setup.bash
#export ROS_PACKAGE_PATH=~/fuerte_workspace:$ROS_PACKAGE_PATH
#export ROS_WORKSPACE=~/fuerte_workspace
#export ROS_HOSTNAME=localhost
##export ROS_MASTER_URI=http://robot.local:40876
#export ROS_MASTER_URI=http://localhost:40876

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Esto se usa para que emacs no crashee en elementary OS
alias emacs="XLIB_SKIP_ARGB_VISUALS=1 emacs"

# Hace que clear borre la salida de verdad
alias clear="clear;clear"

export PATH=$PATH:/home/santiago/Downloads/go/bin
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/usr/local/cuda
#export PATH=$PATH:/opt/microchip/xc8/v1.21/bin
#
#export PATH=$PATH:"/opt/microchip/xc16/v1.20/bin"

export GOPATH=~/golang
export _ARC_DEBUG=1
export M5_PATH=/home/santiago/fullsystems/

makehead () {
    cmd=`head -1 $1 | cut -c 3-`;
    if [[ ("${cmd:0:4}" == "gcc ") || ("${cmd:0:4}" == "g++ ") ]]
    then
        echo $cmd
        bash -c "$cmd"
    else
        if [ -f ./Makefile ]
        then
            make
        elif [ -f ./pymk.py ]
        then
            ./pymk.py
        else
            echo "Could not guess build method"
        fi
    fi
}

clocdir () {
    find $1 -maxdepth 1 -mindepth 1 -type d -print0 \
    | xargs -0 -i sh -c "printf '\033[0;31m\nDirectory: {}\033[0m\n'; cloc {}"
}

search () {
    if [ -z $1 ]
    then
        echo Missing search pattern.
        return 0
    fi

    files="./*.c ./*.h"

    set_red="\033[1;31m\033[K"
    set_green="\033[1;32m\033[K"
    set_yellow="\033[1;33m\033[K"
    set_blue="\033[1;34m\033[K"
    set_default="\033[m\033[K"

    for f in $files
    do
        PATT=$1 \
        awk \
        -v red_v=$set_red \
        -v def_v=$set_default \
        -v filename=$set_green$f$set_default \
            'BEGIN {
                cnt=0;
                res="";
                red = red_v;
                def = def_v;
             }
             match($0,ENVIRON["PATT"],m) {
                subs = red m[0] def;
                cnt+=gsub(ENVIRON["PATT"],subs);
                res=res"\t"$0"\n";
             }
             END {
                if (cnt > 0) {
                    print filename ": " cnt;
                    print res;
                }
             }' $f # 2>/dev/null
    done
}

replace () {
    if [ -z $1 ]
    then
        echo Missing search pattern.
        return 0
    fi

    if [ -z $2 ]
    then
        echo Missing replace pattern value.
        return 0
    fi

    files="./*.c ./*.h"

    set_red="\033[1;31m\033[K"
    set_green="\033[1;32m\033[K"
    set_yellow="\033[1;33m\033[K"
    set_blue="\033[1;34m\033[K"
    set_default="\033[m\033[K"

    stdout=""
    for f in $files
    do
        line=$(
            PATT=$1 \
            awk \
            -v filename=$set_green$f$set_default \
            'BEGIN {
                cnt=0;
                def = def_v;
             }
             match($0,ENVIRON["PATT"],m) {
                cnt+=gsub(ENVIRON["PATT"],"");
             }
             END {
                if (cnt > 0) {
                    print filename ": " cnt;
                }
             }' $f # 2>/dev/null
        )

        if [ -n "$line" ] && [ -w "$f" ]
        then
            PATT=$1 \
            REPL=$2 \
            awk '{gsub(ENVIRON["PATT"],ENVIRON["REPL"]); print;}' $f > tmp
            mv tmp $f
        fi

        if [ -z "$stdout" ]
        then
            stdout=$line
        elif [ -n "$line" ]
        then
            stdout="$stdout\n$line"
        fi
    done
    echo -e $stdout
}


