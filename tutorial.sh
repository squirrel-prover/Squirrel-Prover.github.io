#!/bin/bash

headerfile="tutorial_header.md"

outfile="tutorial_src.md"

infile="squirrel-prover/examples/tutorial/tutorial.sp"


if [ -f "$outfile" ]; then
    rm  "$outfile"
fi

cat $headerfile >> "$outfile"

cat $infile  | sed -E "s/\`\`\`\\*\\)/\`\`\`squirrel/"  | sed -E "s/\\(\\*//" | sed -E "s/\\*\\)\\n//" >> "$outfile"
