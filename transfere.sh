#!/usr/bin/env bash

# Send a file to a server, and then from there
# to other servers that are on the same machine or close by

nodes=$1
file=$2
path=$3
pass=$4
entry=$(head -1 $nodes)

command -v sshpass >/dev/null 2>&1 || { sudo apt-get install sshpass; exit 1; }

entryssh() {
    sshpass -p $pass ssh $entry "$1"
}

sshpass -p $pass scp $file "$entry":$path &&
entryssh "command -v sshpass >/dev/null 2>&1 || { sudo apt-get install sshpass; exit 1; }";
    for server in $(tail -n+2 $nodes); do
        entryssh "ssh-keygen -F $server && 
        ssh-keyscan -H $server >> ~/.ssh/known_hosts; 
        sshpass -p $pass scp $file $server:$path"
    done
