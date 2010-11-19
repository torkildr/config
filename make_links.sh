#!/bin/bash

userdir=$(echo ~)
curdir=$(pwd)
reldir=${curdir:${#userdir}+1}

force=0

while getopts ":f" opt; do
    case $opt in
        f)
            force=1
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
    esac
done

for file in $(find -type f ! -path "./.git/*" -a -! -path $0); do

    base=${file:2}

    if [ $force -eq 1 -o ! -f ~/${file} ]; then
        echo "Creating symlink: ${base} -> ~/${base}"
        ln -sf "$curdir/${base}" ~/${base}
    else
        echo "Symlink already in place: ~/${base}"
    fi

done

