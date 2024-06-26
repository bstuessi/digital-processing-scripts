for file in *;
    do
        SIPdir=~/Desktop/SIPs/${file:0:6}/data/photo/;
        if [[ -d $SIPdir ]]
        then
            mv -iv $file $SIPdir;
        else
            echo "$SIPdir does not exist"
        fi;
    done;
