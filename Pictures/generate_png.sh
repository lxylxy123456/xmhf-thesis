#!/bin/bash

set -xe

[ -d "Pictures/" ]
[ "$#" == "1" ]
[ -f "$1" ]

NAME="${1#Pictures/}"
NAME="${NAME%.tex}"
[ "Pictures/$NAME.tex" == "$1" ]

TMPD="$(mktemp -d)"
pdflatex -output-directory "$TMPD" "$1"
PDF="$TMPD/$NAME.pdf"
[ -f "$PDF" ]

convert -density 300 "$PDF" "pngs/$NAME.png"

rm -r "$TMPD"

