#!/usr/bin/bash

AIP_PATH="$1"

mkdir $AIP_PATH/extracted_files

for d in $AIP_PATH/disk_image/*.000;
    do
        IMAGE_BASE=$(basename $d)
        mkdir $AIP_PATH/extracted_files/${IMAGE_BASE%.*}
        sudo fmount -t $d 2>&1 | tee ${d}_tmp
        MOUNTED_IMAGE=$(grep -E -o '\/.+\/' ${d}_tmp)
        rsync -av $MOUNTED_IMAGE/ $AIP_PATH/extracted_files/${IMAGE_BASE%.*}/
        sudo rm ${d}_tmp
        sudo umount $MOUNTED_IMAGE
done;