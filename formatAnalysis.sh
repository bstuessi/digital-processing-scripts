#!/usr/bin/bash

BASE_PATH="$1"

EXTRACTED_PATH=${BASE_PATH}/extracted_files/

brunnhilde.py -bon $EXTRACTED_PATH ${BASE_PATH}/reports/brunnhilde

python3 /home/bcadmin/code/digital-processing-scripts/aggregateFormats.py $BASE_PATH

echo "\nFormats added to formatReport.json"