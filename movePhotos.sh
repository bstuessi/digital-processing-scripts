for file in *;
    do
        SIPdir=~/Desktop/SIPs/${file%.*}/data/photo;
        if [[ -d $SIPdir ]]
        then
            mv -iv $file $SIPdir/;
        fi;
    done;
