#This script takes a SIP folder as input and runs the necessary virus check and DFXML report

#Brock Stuessi, Digital Archivist
#May 2023

IMAGE="$1"/data/disk_image/"$1".000

sudo fmount -t "$IMAGE"

touch "$1"/data/reports/"$1"_virus_check.txt

clamscan -r /media/"$1"_vol0 | tee "$1"/data/reports/"$1"_virus_check.txt

fiwalk -X"$1"/data/reports/"$1"_dfxml.xml "$IMAGE"

mv "$1"/data/disk_image/"$1".info "$1"/data/reports/"$1".info

sudo umount /media/"$1"_vol0