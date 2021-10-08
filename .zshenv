# https://askubuntu.com/questions/548883/kubuntu-14-10-zshenv-is-sourced-twice?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
new_path+=($HOME/bin)
new_manpath+=($HOME/man)

## HOMEBREW
new_path+=(/usr/local/opt/coreutils/libexec/gnubin /usr/local/opt/grep/libexec/gnubin)

export EDITOR=emacs

# tabbed & st
new_path+=($HOME/tools/tabbed/bin $HOME/tools/st/bin)
new_manpath+=($HOME/tools/tabbed/share/man $HOME/tools/st/share/man)

# keep default
new_manpath+=(/usr/share/man /usr/local/share/man)

# pip
new_path+=(/Users/tameling/Library/Python/2.7/bin)

# ruby gems
new_path+=(/Users/tameling/.gem/ruby/2.6.0/bin)

# go
new_path+=(/Users/tameling/go/bin)

# clangd
new_path+=(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/)

# texlive
new_path+=(/usr/local/texlive/2021/bin/universal-darwin)
new_manpath+=(/usr/local/texlive/2021/texmf-dist/doc/man)

# path=(${new_path:|path} $path)
path=($new_path $path)
manpath=($manpath ${new_manpath:|manpath})
typeset -aU path manpath
unset new_manpath new_path

export MUTTSYNCCMD="mbsync -a"
export MANPAGER=less
