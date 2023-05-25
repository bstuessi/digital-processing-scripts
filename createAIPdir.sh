#!/usr/bin/bash

#Help output

Help() {
    cat <<EOF
Purpose: 

Syntax: createAIP -a [path to existing repository to add to] -o (optional flag to overwrite corresponding directory) <path to SIP directory>

EOF
exit 1
}

#Options
while getopts "a:o:h" option; do
    case $option in 
        a) # add to existing directory
            AIP_BASE=$OPTARG
            ADD=1
            shift 2 ;;
        o) # overwrite directory
            OVERWRITE=1 
            shift 1 ;;
        h) Help ;;
    esac
done

SIP_PATH="$1"

SIP_BASE=$(basename $SIP_PATH)

if [[ -n $AIP_BASE ]];
    then
        NEW_AIP=${AIP_BASE%"AIP"}${SIP_BASE%"SIP"}AIP
        mv ${AIP_BASE%/} $NEW_AIP
        AIP_BASE=$NEW_AIP

    else
        AIP_BASE=${SIP_BASE%"SIP"}AIP
fi

if [[ $OVERWRITE == 1 ]];
    then
        sudo rm -r $AIP_BASE
fi
        
mkdir $AIP_BASE 

echo "Copying files from SIP to AIP directory..."

rsync -av $SIP_PATH $AIP_BASE/

echo "Validating bag..."

bagit.py --validate ${AIP_BASE}/${SIP_BASE}

read -p "Is the bag valid, would you like to continue with processing? Y/N:" CONT

if [[ $CONT == "Y" ]];
    then
        if [[ $ADD == 1 ]];
            then
                echo "Unbagging AIP directory..."
                mv $AIP_BASE/$SIP_BASE/data/disk_image/* $AIP_BASE/disk_image/
                mv $AIP_BASE/$SIP_BASE/data/photo/* $AIP_BASE/photo/
                mv $AIP_BASE/$SIP_BASE/data/reports/* $AIP_BASE/reports/
                rm -r $AIP_BASE/$SIP_BASE
                echo "Done."
            else
                echo "Unbagging AIP directory..."
                mv $AIP_BASE/$SIP_BASE/data/* $AIP_BASE
                rm -r $AIP_BASE/$SIP_BASE
                echo "Done."
        fi
    else
        exit
fi