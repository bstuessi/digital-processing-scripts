#!/bin/bash

OUT_DIR="$1"
IN_DIR="$2"

mkdir $OUT_DIR

ncdu -r -o $OUT_DIR/${OUT_DIR}_ncdu "$IN_DIR"

tree -d -L 5 "$IN_DIR" > $OUT_DIR/${OUT_DIR}_directory_tree.txt

#source /Users/mkf26/Documents/code/digital-processing-scripts/dateRangeMacOS.sh "$IN_DIR"

ncdu -f $OUT_DIR/${OUT_DIR}_ncdu