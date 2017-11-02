. /usr/local/etc/.bash

alias ll='ls -l'
alias la='ls -la'

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
 
prompt_command () {
    local err_prompt=`prt_ret`
    export PS1="${err_prompt}`prt_virtualenv`[`prt_username`@`prt_hostname`:`prt_dir` `prt_time`]`prt_git`\n\[${TURNOFF}\]$ \[${TURNOFF}\]"
}

PROMPT_COMMAND=prompt_command

prt_ret () {
    RET=$?
    if [ $RET -ne 0 ]; then
        echo "\[${RED}\]O.o ${RET} \[${TURNOFF}\]"
    else
        echo "\[${TURNOFF}\]:) \[${TURNOFF}\]"
    fi
}

prt_virtualenv () {
    if [ $VIRTUAL_ENV ]; then
        d=`dirname $VIRTUAL_ENV`
        parent="`basename \`dirname $VIRTUAL_ENV\``/`basename $VIRTUAL_ENV`"
        echo "\[${MAGENTA}\]($parent)\[${TURNOFF}\] "
    fi
}

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

prt_username () {
    who=`whoami`
    if [ $who = "root" ]; then
        echo "\[${BRED}\]${who}\[${TURNOFF}\]"
    else
        echo "\[${GREEN}\]${who}\[${TURNOFF}\]"
    fi
}

prt_hostname () {
    echo "\[${MAGENTA}\]\h\[${TURNOFF}\]"
}

prt_dir () {
    echo "\[${CYAN}\]\w\[${TURNOFF}\]"
}

prt_time () {
    val=`date +"%k:%M:%S"`
    echo "\[${YELLOW}\]$val\[${TURNOFF}\]"
}
