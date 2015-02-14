# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

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
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
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
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # colors & promt
	green=$(tput setaf 2)
	blue=$(tput setaf 4)
	yellow=$(tput setaf 3)
	lightRed=$(tput setaf 1)
	bold=$(tput bold)
	reset=$(tput sgr0)


	# Detect whether the current directory is a git repository.
	function is_git_repository {
	  git branch > /dev/null 2>&1
	}
	 
	# Determine the branch/state information for this git repository.
	function set_git_branch {
	  # Capture the output of the "git status" command.
	  git_status="$(git status 2> /dev/null)"
	 
	  # Set color based on clean/staged/dirty.
	  if [[ ${git_status} =~ "working directory clean" ]]; then
	    state=$green
	  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
	    state=$yellow
	  else
	    state=$lightRed
	  fi
	 
	  # Set arrow icon based on status against remote.
	  remote_pattern="Your branch is (.*) of"
	  if [[ ${git_status} =~ ${remote_pattern} ]]; then
	    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
	      remote="↑"
	    else
	      remote="↓"
	    fi
	  else
	    remote=""
	  fi
	  diverge_pattern="Your branch and (.*) have diverged"
	  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
	    remote="↕"
	  fi
	 
	  # Get the name of the branch.
	  branch_pattern="^On branch ([^${IFS}]*)"
	  if [[ ${git_status} =~ ${branch_pattern} ]]; then
	    branch=${BASH_REMATCH[1]}
	  fi
	 
	  # Set the final branch string.
	  BRANCH="${state}(${branch})${remote}$reset "
	}
	 
	# Return the prompt symbol to use, colorized based on the return value of the
	# previous command.
	function set_prompt_symbol () {
	  if test $1 -eq 0 ; then
	      PROMPT_SYMBOL="\$"
	  else
	      PROMPT_SYMBOL="$lightRed\$${COLOR_NONE}"
	  fi
	}
	 
	# Determine active Python virtualenv details.
	function set_virtualenv () {
	  if test -z "$VIRTUAL_ENV" ; then
	      PYTHON_VIRTUALENV=""
	  else
	      PYTHON_VIRTUALENV="$blue[`basename \"$VIRTUAL_ENV\"`]$reset "
	  fi
	}
	 
	# Set the full bash prompt.
	function set_bash_prompt () {
	  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
	  # return value of the last command.
	  set_prompt_symbol $?
	 
	  # Set the PYTHON_VIRTUALENV variable.
	  set_virtualenv
	 
	  # Set the BRANCH variable.
	  if is_git_repository ; then
	    set_git_branch
	  else
	    BRANCH=''
	  fi
	 
	  # Set the bash prompt variable.
	  PS1="\n\[$green$bold\]\d \t \l\[$reset\]: ${PYTHON_VIRTUALENV}\[$blue$bold\]\w\[$reset\]\n\[$green$bold\]\u@\h ${BRANCH}${PROMPT_SYMBOL} \[$reset\]"
	}
	 
	# Tell bash to execute this function just before displaying its prompt.
	PROMPT_COMMAND=set_bash_prompt
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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
