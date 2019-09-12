# https://askubuntu.com/questions/548883/kubuntu-14-10-zshenv-is-sourced-twice?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
new_path=("/opt/local/libexec/gnubin/")
new_manpath=("/opt/local/libexec/gnuman/")

#add ~/bin to you exacutable search path
new_path+=($HOME/bin/)

# neomutt
new_path+=("$HOME/bin/neomutt/bin")

## FOR MACPORTS
new_path+=(/opt/local/bin /opt/local/sbin)
new_manpath+=(/opt/local/share/man)

export EDITOR=emacs

# tabbed & st
new_path+=($HOME/tools/tabbed/bin $HOME/tools/st/bin)
new_manpath+=($HOME/tools/tabbed/share/man $HOME/tools/st/share/man)

# path=(${new_path:|path} $path)
path=($new_path $path)
manpath=($manpath ${new_manpath:|manpath})
typeset -aU path
unset new_manpath new_path

export MUTTSYNCCMD="mbsync -a"
