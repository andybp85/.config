#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# colors & promt
green=$(tput setaf 2)
blue=$(tput setaf 4)
bold=$(tput bold)
reset=$(tput sgr0)
PS1='\n\[$green$bold\]\d \t \l\[$reset\]:\[$blue$bold\]\w\[$reset\]\n\[$green$bold\]\u@\h\[$reset\] \$ '
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

