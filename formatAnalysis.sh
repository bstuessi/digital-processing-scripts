#!/usr/bin/bash

BASE_PATH="$1"

EXTRACTED_PATH=${BASE_PATH}/extracted_files

brunnhilde.py -bon $EXTRACTED_PATH ${BASE_PATH}/reports/brunnhilde

python3 '/home/bcadmin/code/accessioning-scripts/format_analysis.py' $EXTRACTED_PATH
