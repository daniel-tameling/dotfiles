alias ls='ls -hF --color=auto'
eval `dircolors ~/.dir_colors`

alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -l'
alias la='ls -la'
alias l.='ls -d .*'
alias lt='ls -ltr'
alias lld='\ls -hld --color=always */' # execute without -F
alias emacs='emacs -nw'
export EDITOR='emacs -nw'

# saver remove
if [ -n "$PS1" ] ; then
  rm ()
  {
    ls -hFCsd "$@"
    echo 'remove[ny]? ' | tr -d '\012' ; read
    if [ "_$REPLY" = "_y" ]; then
        /bin/rm -rf "$@"
    else
        echo '(cancelled)'
    fi
  }
fi

#colors for prompt
if [ "$TERM" != "dumb" ]; then
  if type -P tput > /dev/null; then 
    TURNOFF=`tput sgr0`
 
    # fg colors
    BLACK=`tput setaf 0`
    RED=`tput setaf 1`
    GREEN=`tput setaf 2`
    YELLOW=`tput setaf 3`
    BLUE=`tput setaf 4`
    MAGENTA=`tput setaf 5`
    CYAN=`tput setaf 6`
    WHITE=`tput setaf 7`
 
    # bold fg colors
    BBLACK=`tput bold && tput setaf 0`
    BRED=`tput bold && tput setaf 1`
    BGREEN=`tput bold && tput setaf 2`
    BYELLOW=`tput bold && tput setaf 3`
    BBLUE=`tput bold && tput setaf 4`
    BMAGENTA=`tput bold && tput setaf 5`
    BCYAN=`tput bold && tput setaf 6`
    BWHITE=`tput bold && tput setaf 7`
  else
    TURNOFF="\033[0m"
 
    # fg colors
    BLACK="\033[0;30m"
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[0;33m"
    BLUE="\033[0;34m"
    MAGENTA="\033[0;35m"
    CYAN="\033[0;36m"
    WHITE="\033[0;37m"
 
    # bold fg colors
    BRED="\033[1;31m"
    BGREEN="\033[1;32m"
    BYELLOW="\033[1;33m"
    BBLUE="\033[1;34m"
    BMAGENTA="\033[1;35m"
    BCYAN="\033[1;36m"
    BWHITE="\033[1;37m"
  fi
fi
 
prt_git () {
    # Check if inside a git repo
    git branch > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        return 0
    fi

    # Capture the output of the "git status" command.
    git_status=`git status 2> /dev/null`

    # Set color based on clean/staged/dirty.
    if [[ ${git_status} =~ "working directory clean" ]]; then
        state="\[${GREEN}\]"
    elif [[ ${git_status} =~ "Changes to be committed" ]]; then
        state="\[${YELLOW}\]"
    else
        state="\[${RED}\]"
    fi

    # Set arrow icon based on status against remote.
    remote_pattern="# Your branch is (.*) of"
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
            remote="↑"
        else
            remote="↓"
        fi
    else
        remote=""
    fi
    diverge_pattern="# Your branch and (.*) have diverged"
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="↕"
    fi

    # Get the name of the branch.
    branch_pattern="^# On branch ([^${IFS}]*)"
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
         branch=${BASH_REMATCH[1]}
    fi

    # Set the final branch string.
    echo "${state}(${branch})${remote}\[${TURNOFF}\]"
}

prt_ret () {
  local RET=$?
  if [[ ${RET} != 0 ]]; then
    echo "\[${RED}\][${RET}]\[${TURNOFF}\]"
  fi
}
 
prt_user () {
 echo "\[${GREEN}\]\u\[${TURNOFF}\]"
}
 
prt_host () {
  echo "\[${MAGENTA}\]\h\[${TURNOFF}\]"
}
 
prt_user_host () {
  echo "\[${GREEN}\][\u|\h]\[${TURNOFF}\]"
}
 
prt_path () {
  echo "\[${CYAN}\]\w\[${TURNOFF}\]"
}
 
prt_time () {
  echo "\[${YELLOW}\]\t\[${TURNOFF}\]"
}
 
set_prompt () {
  local err_prompt=`prt_ret`
  PS1="`prt_user_host` `prt_time` `prt_path` ${err_prompt}\n\[${TURNOFF}\]$ \[${TURNOFF}\]"
}

if [ "$TERM" != "dumb" ]; then 
  PROMPT_COMMAND=set_prompt

  bind "set completion-ignore-case on"
  bind "set show-all-if-ambiguous on"
fi
 
shopt -s autocd
export HISTCONTROL=ignoreboth
export HISTSIZE=50000
export HISTFILESIZE=50000
