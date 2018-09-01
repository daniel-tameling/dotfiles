#!/bin/bash

# read tmpdir < <(mktemp -d /tmp/print_preview-$USER-XXXXXXXX)
# cd $tmpdir || exit 1

# trap "cd && rm -fR $tmpdir;exit" 0 1 2 3 6 9 15


cd ~/.mutt/print || exit 1
cat >file.txt
~/gopdf/gopdf -i file.txt

open output.pdf
