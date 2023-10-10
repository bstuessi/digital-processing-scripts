#!/usr/bin/bash

EXTRACTED_DIR="$1"

ACCESS_DIR="$2"

if [[ ! -d "$ACCESS_DIR" ]];
    then mkdir "$ACCESS_DIR";
fi;

COUNT=0

#conversion loop for .doc files
for doc in "${EXTRACTED_DIR}"/*.doc;
    #for each file ending in .doc convert to pdf
    do soffice --headless --convert-to pdf "$doc" --outdir "$ACCESS_DIR";
    #reformat name
    filename=$(basename "$doc");
    mv "$ACCESS_DIR"/"${filename%.*}".pdf "$ACCESS_DIR"/"${filename}".pdf;
    ((COUNT++));
done;

#conversion for word perfect files without an extension
for f in "${EXTRACTED_DIR}"/*;
    do 
    #check for file type and no extension
    if [[ $(file --mime-type -b "$f") == "application/octet-stream" && $(file --extension -b "$f") == "???" ]] ;
        #conversion
        then soffice --headless --convert-to pdf "$f" --outdir "$ACCESS_DIR";
        #renaming
        filename=$(basename "$f");
        mv "$ACCESS_DIR"/"${filename%.*}".pdf "$ACCESS_DIR"/"${filename}".pdf;
        ((COUNT++));
    fi;
done;

TOTAL_FILE_COUNT=$(find "$EXTRACTED_DIR" -type f | wc -l)

#print statement to verify changes
echo $COUNT of $TOTAL_FILE_COUNT files converted to PDF access files



