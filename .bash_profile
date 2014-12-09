#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

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

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

