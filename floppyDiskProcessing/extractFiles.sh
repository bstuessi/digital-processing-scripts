#!/usr/bin/bash

#Help output/usage

Help() {
    cat <<EOF
Purpose: Extract files from a disk image

Syntax: bash path/to/extractFiles.sh <PATH to AIP directory>

EOF
exit 1
}

#Options
while getopts "h" option; do
    case $option in 
        h) Help ;;
    esac
done


#assigns the first input following the shell script command in the terminal to the variable AIP_PATH
AIP_PATH="$1"

#make a directory in the AIP directory for the extracted files
mkdir $AIP_PATH/extracted_files

#loop through disk images in the disk_image folder in the AIP directory
for d in $AIP_PATH/disk_image/*.000;
    do
        #get basename of image for naming purposes
        IMAGE_BASE=$(basename $d)
        #make directory in new extracted_files directory for image files
        mkdir $AIP_PATH/extracted_files/${IMAGE_BASE%.*}
        #mount the image using root privileges and create a temporary text file with the output from the mount command
        sudo fmount -t $d 2>&1 | tee ${d}_tmp
        #set MOUNTED_IMAGE to loaction of image by doing a regular expression grep search call on the temporary text file created above
        MOUNTED_IMAGE=$(grep -E -o '\/.+\/' ${d}_tmp)
        #copy the contents of the mounted image to the corresponding extracted files directory preserving the metadata with -a and printing progress with -v options
        rsync -av $MOUNTED_IMAGE/ $AIP_PATH/extracted_files/${IMAGE_BASE%.*}/
        #delete the temporary text file
        sudo rm ${d}_tmp
        #using root privileges, unmount the image 
        sudo umount $MOUNTED_IMAGE
done;