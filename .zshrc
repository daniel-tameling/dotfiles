#!/bin/zsh

# use colors with ls (only on LINUX)
# if [ $R_OSTYPE = LINUX ]; then
#   alias ls='ls -F --color=auto'
#   LS_COLORS='di=96;01:fi=00:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=92:*.o=36:*.cpp=93:*.c=93:*.h=33:*.sh=95'
#   export LS_COLORS
# else
#   alias ls='ls -F'
# fi
#export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    eval `dircolors ~/.dir_colors`
fi

# Useful aliases
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls -l' 
alias la='ls -la'
alias l.='ls -d .*'
alias lt='ls -ltr'
alias lld='ls -ld *(/)'

#always prompt befor overwriting on cp or mv & nocorrection for commands 
alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias mkdir='nocorrect mkdir'
alias rm='rm -v' #prompt before removal & do not remove root & explain what is deleted
alias emacs='emacs -nw' #emacs not in x11 window

if [ -n "$PS1" ] ; then
  rm ()
  {
      ls -FCsd "$@"
      echo 'remove[ny]? ' | tr -d '\012' ; read
      if [ "_$REPLY" = "_y" ]; then
          /bin/rm -rf "$@"
      else
          echo '(cancelled)'
      fi
  }
fi

# Colorize the grep command output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# autocorrection
setopt correctall

# command history 
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
setopt histignorealldups sharehistory
setopt hist_ignore_space

# autocd 
setopt autocd

# zmv
autoload zmv

# change prompt
setopt prompt_subst

# get battery charge
battery_status () {
    local bat_status bat_color
    bat_status=$(ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.2f"; max=c["\"DesignCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}')
    # Set color depending on battery status
    if [[ ${bat_status} -gt 50.00 ]]; then
        bat_color="%F{green}"
    elif [[ ${bat_status} -gt 25.00 ]]; then
        bat_color="%F{yellow}"
    else
        bat_color="%F{red}"
    fi
    print -f "%s%.2f %s" "%{${bat_color}%}" "${bat_status}" "%%%{%f%}"
}

# version control information
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true 
zstyle ':vcs_info:*' unstagedstr '%F{1}'
zstyle ':vcs_info:*' stagedstr '%F{3}'
zstyle ':vcs_info:*' actionformats '%F{2}%u%c%b%m%f-%F{1}[%a]%f'
zstyle ':vcs_info:*' formats '%F{2}%u%c%b%m%f'
# hook whether ahead/behind remote
zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( " +${ahead}" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( " -${behind}" )

    hook_com[misc]+=${(j::)gitstatus}
}
# hook display name of remote
# zstyle ':vcs_info:git*+set-message:*' hooks git-remotebranch
# function +vi-git-remotebranch() {
#     local remote

#     # Are we on a remote-tracking branch?
#     remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
#                    --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

#     # The first test will show a tracking branch whenever there is one. The
#     # second test, however, will only show the remote branch's name if it
#     # differs from the local one.
#     if [[ -n ${remote} ]] ; then
#         #if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
#         hook_com[branch]="${hook_com[branch]} [${remote}]"
#     fi
# }

#right prompt
RPROMPT='`battery_status`'

#change the command prompt to use colors and print the current directory
## with this the prompt isn't reprinted when the terminal size changes
precmd() {vcs_info}
prmptcmd() {print -P '%F{green}[%n|%m]%f %F{yellow}%*%f %F{cyan}%~%f ${vcs_info_msg_0_}%(?.. %F{red}[%?]%f)'}
precmd_functions=(prmptcmd)
PS1="%(!.#.$) "

## Completions
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


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
#activate only when supported
if [[ -n ${terminfo[smkx]} ]] && [[ -n ${terminfo[rmkx]} ]]; then
    zle -N zle-line-init
    zle -N zle-line-finish 
   # for terminator and xfce-terminal
   bindkey ';5D' emacs-backward-word
   bindkey ';5C' emacs-forward-word
   # for st
   bindkey '5D' emacs-backward-word
   bindkey '5C' emacs-forward-word
fi
