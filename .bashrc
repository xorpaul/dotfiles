# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
#export HISTCONTROL=ignoreboth


# from http://administratosphere.wordpress.com/2011/05/20/logging-every-shell-command/
export HISTCONTROL=
export HISTFILE=$HOME/.bash_history
export HISTFILESIZE=60000
export HISTIGNORE=
export HISTSIZE=20000
export HISTTIMEFORMAT="%a %b %Y %T %z "

shopt -s cmdhist

PROMPT_COMMAND="history -a"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export LANG='en_US'
export EDITOR=vim

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
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

#dynamic konsole terminal tabnames
export PS1=$PS1"\[\e]30;\h:\W\a\e[28;0t\]"


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b ~/.dircolorsrc`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more aliases
alias top='top -c'
alias sb='sudo bash'
alias nr='/etc/init.d/nagios checkconfig && sleep 5 && /etc/init.d/nagios reload'
alias v='vi'
alias vu='vi'
alias vo='vi'
alias ll='ls -lph'
alias lla='ls -lpah'
alias la='ls -laph'
alias lt='ls -laptr'
alias llt='ls -lpatr'
alias l='ls -lph'
alias k='ls -lph'
alias cdp='cd /etc/puppet/manifests/'
alias cds='cd /usr/local/nagios_mon/nagios/etc/services'
alias cdo='cd /usr/local/nagios_mon/nagios/etc/objects'
alias igrep='grep -i'
alias scp='scp -p'
alias s='sudo'
alias sb='sudo bash'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias md='mkdir'
alias rd='rm -r'
alias lcd-off='xset dpms force off'
#alias ssh='ssh -c arcfour,blowfish-cbc'
alias df='df -h'
alias uo='sudo apt-get update && echo -e "\n############################################ \n## update finished \n############################################\n"  && sudo apt-get upgrade && echo -e "\n############################################ \n## upgrade finished \n############################################\n"  && sudo apt-get dist-upgrade'
alias passgen='cat /dev/urandom|tr -dc "a-zA-Z0-9-_\$\?"|fold -w 9|head'
alias dstat='dstat -Dsda,sdb'
alias jdefault="java -server -XX:+UnlockDiagnosticVMOptions -XX:+PrintFlagsFinal -version"
alias renamehtm="rename 's/\.htm$//' *.htm"


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
############################################


###### SSH Port Tunnel
#ssh -L8080:localhost:80 pps.getmyip.com -p 443
# merge pdfs
#gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=out.pdf titelblatt.pdf praxis3.pdf
#sudo update-alternatives --config gnome-video-thumbnailer

#rename 's/\.htm$//' *.htm
#find . -size +2M -print0 | xargs -0 -i mv '{}' /68/

#### FUNCTIONS ####

function swap()          
{ 
    local TMPFILE=tmp.$$ 
    mv "$1" $TMPFILE 
    mv "$2" "$1" 
    mv $TMPFILE "$2" 
} 

# mkdir, cd into it
mdcd () {
  mkdir -p "$*"
  cd "$*"
}

#backup file
function backup()
{
  cp -rp "$1" "$1-"`date +%Y-%m-%d`
}

#scp to server
function scc()
{
  scp -r schlundi:"$1" "$1"
  scp -r "$1" "$2":
}

function paulafy()
{
  echo "#############"
  echo "paulafy: $1"
  echo "-------------"
  /usr/bin/scp -r ~/.ssh ~/.vim ~/.dircolorsrc ~/.vimrc ~/.bashrc ~/.bash_aliases ~/local.profile ~/.profile ~/.inputrc paula@$1:
  echo "#############"
}

function paulify()
{
  servers=( )
 
  for server in ${servers[@]}
    do
      paulafy $server
  done
}

extract () {
        if [ -f $1 ] ; then
                case $1 in
                        *.tar.bz2)      tar xjf $1              ;;
                        *.tar.gz)       tar xzf $1              ;;
                        *.bz2)          bunzip2 $1              ;;
                        *.rar)          rar x $1                ;;
                        *.gz)           gunzip $1               ;;
                        *.tar)          tar xf $1               ;;
                        *.tbz2)         tar xjf $1              ;;
                        *.tgz)          tar xzf $1              ;;
                        *.zip)          unzip $1                ;;
                        *.Z)            uncompress $1   ;;
                        *)                      echo "'$1' cannot be extracted via extract()" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}

jstats () {
      if [ -d /usr/share/$1/temp ]; then
          jstat -J-Djava.io.tmpdir=/usr/share/$1/temp -gcutil `cat /usr/share/$1/tomcat?.pid` 2000
      else
          echo "'$1' is not a directory"
      fi
}

taca () {
      FILE=/var/log/$1/catalina.out
      if [ -r $FILE ]; then
          echo "tailing $FILE"
          tail -n400 -f $FILE
      else
          echo "'$FILE' is not accessible"
      fi
}

function vho()
{
  vi /etc/apache$1/vhosts.inc
}
