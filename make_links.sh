#!/bin/bash

userdir=$(echo ~)
curdir=$(pwd)
reldir=${curdir:${#userdir}+1}

for file in $(find -type f ! -path "./.git/*" -a -! -path $0); do

    base=${file:2}

    if [ ! -f ~/${file} ]; then
        echo "Creating symlink: ${base} -> ~/${base}"
        ln -s "${reldir}/${base}" ~/${base}
    else
        echo "Symlink already in place: ~/${base}"
    fi

done

