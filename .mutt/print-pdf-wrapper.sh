#! /usr/bin/env bash

# read tmpdir < <(mktemp -d /tmp/print_preview-$USER-XXXXXXXX)
# cd $tmpdir || exit 1

# trap "cd && rm -fR $tmpdir;exit" 0 1 2 3 6 9 15


cd ~/.mutt/print || exit 1
cat >file.txt
exec </dev/tty >/dev/tty
emacs file.txt
read -p 'Title for the pdf: ' title
if [ -z "$title" ]; then
   ~/gopdf/gopdf -i file.txt
else
   ~/gopdf/gopdf -i file.txt -t $title
fi

open output.pdf
