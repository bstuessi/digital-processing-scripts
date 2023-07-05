#This script takes a SIP folder as input and runs the necessary virus check and DFXML report

#Brock Stuessi, Digital Archivist
#May 2023

IMAGE="$1"/disk_image/"$1".000

sudo fmount -t "$IMAGE" 2>&1 | tee ${IMAGE}_tmp

MOUNTED_IMAGE=$(grep -E -o '\/.+\/' ${IMAGE}_tmp)

touch "$1"/reports/"$1"_virus_check.txt

clamscan -r $MOUNTED_IMAGE | tee "$1"/reports/"$1"_virus_check.txt

fiwalk -X"$1"/reports/"$1"_dfxml.xml "$IMAGE"

mv "$1"/disk_image/"$1".info "$1"/reports/"$1".info

sudo umount $MOUNTED_IMAGE

sudo rm ${IMAGE}_tmp