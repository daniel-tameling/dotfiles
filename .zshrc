# ================================================================
# Dieses Profile wird bei jedem Login von der zsh durchlaufen.
# Sie koennen es unter Verwendung der zsh-Syntax nach Ihren 
# Beduerfnissen anpassen.
#
# Wenn Sie zum Arbeiten eine andere Shell als die zsh - z.B. die
# tcsh - wuenschen, sollten Sie AM ENDE dieser Datei die folgenden 
# Zeilen hinzufuegen:
#
#     if [[ -o login ]]; then
#        tcsh; exit
#     fi
# ================================================================

#always prompt befor overwriting on cp or mv & nocorrection for commands 
alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias mkdir='nocorrect mkdir'
alias rm='rm --preserve-root -v' #prompt before removal & do not remove root & explain what is deleted
alias emacs='emacs -nw' # emacs not in x11 window
alias ll='ls -l' 
alias la='ls -la'
alias l.='ls -d .*'

# Colorize the grep command output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#autocorrection
setopt correctall

# use colors with ls (only on LINUX)
if [ $R_OSTYPE = LINUX ]; then
  alias ls='ls -F --color=auto'
  LS_COLORS='di=96;01:fi=00:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=92:*.o=36:*.cpp=93:*.c=93:*.h=33:*.sh=95'
  export LS_COLORS
else
  alias ls='ls -F'
fi

#add ~/bin to you exacutable search path
export PATH=$PATH:$HOME/bin/

#define you command history and size
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000

## git stuff for prompt; modified Lucas' version 
setopt prompt_subst

BLACK="%{\e[0;30m%}"
RED="%{\e[0;31m%}"
GREEN="%{\e[0;32m%}"
YELLOW="%{\e[0;33m%}"
BLUE="%{\e[0;34m%}"
PINK="%{\e[0;35m%}"
CYAN="%{\e[0;36m%}"
GRAY="%{\e[0;37m%}"

DEFAULT="%{\e[0;0m%}"

# Bold
BRED="%{\e[1;31m%}"
BGREEN="%{\e[1;32m%}"
BYELLOW="%{\e[1;33m%}"
BBLUE="%{\e[1;34m%}"
BPINK="%{\e[1;35m%}"
BCYAN="%{\e[1;36m%}"
BGRAY="%{\e[1;37m%}"

prt_git () {
    # Check if inside a git repo
    git branch > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        return 0
    fi
    # Capture the output of the "git status" -command.
    git_status=`git status 2> /dev/null` 

    # Set color based on clean/staged/dirty.
    if [[ ${git_status} =~ "working directory clean" ]]; then
        state="${GREEN}"
    elif [[ ${git_status} =~ "Changes to be committed" ]]; then
        state="${YELLOW}"
    else
        state="${RED}"
    fi
    # Set arrow icon based on status against remote.
    remote_pattern="# Your branch is (.*) of"
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${match[1]} == "ahead" ]]; then
            remote="\xe2\x86\x91"
        else
            remote="\xe2\x86\x93"
        fi
    else
        remote=""
    fi
    diverge_pattern="# Your branch and (.*) have diverged"
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="\xe2\x86\x95"
    fi

    # Get the name of the branch.
    branch_pattern="^# On branch ([^${IFS}]*)"
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
         branch=${match[1]}
    fi

    # Set the final branch string.
    echo "${state}(${branch})${remote}${DEFAULT}"
}

#change the command prompt to use colors and print the current directory
#export PS1="$(print '%(?.:%).%{\e[0;31m%}:( %?%{\e[0;0m%}) [%{\e[0;32m%}%n%{\e[0;0m%}@%{\e[1;35m%}%m%{\e[0;0m%}:%{\e[0;36m%}%~%{\e[0m%} %{\e[0;33m%}%*%{\e[0;0m%}]\n$ ')"
#export PS1="$(print '%(?.:%).%{\e[0;31m%}:( %?%{\e[0;0m%}) [%{\e[0;32m%}%n%{\e[0;0m%}@%{\e[1;35m%}%m%{\e[0;0m%}:%{\e[0;36m%}%~%{\e[0m%} %{\e[0;33m%}%*%{\e[0;0m%}] `prt_git`\n$ ')"
#without color
#export PS1='[%!]%n@%m:%~$ '

## with this the prompt isn't reprinted when the terminal size changes
precmd() {print -P '%(?.:%).'${RED}':( %?'${DEFAULT}') ['${GREEN}'%n'${DEFAULT}'@'${PINK}'%m'${DEFAULT}':'${CYAN}'%~'${YELLOW}' %*'${DEFAULT}'] `prt_git`'}
export PS1="$ "

## Completions
autoload -U compinit
compinit -C

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#to use Elmar's ejobs and ehosts
export PATH=$PATH:~/.local/bin

# http://zshwiki.org/home/zle/bindkeys ;to make keys do what they are supposed to
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish 