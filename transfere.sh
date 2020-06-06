#!/usr/bin/env bash

# Send a file to a server, and then from there
# to other servers that are on the same machine or close by

NODES=$1
PASS=$2
FILE=$3
FPATH=$4

ENTRY=""

entryssh() {
    sshpass -p $PASS ssh $ENTRY "$1"
}

while IFS=$'@' read -r servuser ip; do
    SUSER+=($servuser)
    ADDR+=($ip)
done <"$NODES"

ENTRY="${SUSER[0]}@${ADDR[0]}"

sshpass -p $PASS scp $FILE "$ENTRY":$FPATH &&
    HEIGHT=$(echo `expr $(wc -l <$NODES) - 1`)
    INDEX=1

while [ $INDEX -le "$HEIGHT" ]
do
    entryssh "ssh-keygen -F ${ADDR[$INDEX]} ||
        ssh-keyscan -H ${ADDR[$INDEX]} >> ~/.ssh/known_hosts;"
    sshpass -p $PASS scp $FILE "${SUSER[$INDEX]}@${ADDR[$INDEX]}:$FPATH"
    
    echo Sending to ${ADDR[$INDEX]} from $ENTRY
    INDEX=$(($INDEX+1))
done

