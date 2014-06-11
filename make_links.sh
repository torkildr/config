#!/bin/bash

userdir=~
curdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
reldir=${curdir:${#userdir}+1}

force=""

cd $curdir

# set -o xtrace
while getopts "hfdu:" opt; do
    case $opt in
        f)
            force="-f"
            ;;
        d)
            dryrun=1
            ;;
        u)
            userdir=$OPTARG
            ;;
        h)
            cat << EOF
Usage:
 -f     force
 -d     dryrun
 -u     specify the user-dir (defaults to ${userdir}
 -h     halps!
EOF
        exit 1
        ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
    esac
done

[[ -n $dryrun ]] && echo Doing dryrun.

echo
echo Inserting symlinks into ${userdir}

for file in $(find . -type f ! -path "./.git/*" -a ! -path "./git-hooks/*" -a ! -path $0); do

    base=${file:2}

    echo "Creating symlink: ${curdir}/${base} -> ${userdir}/${base}"
    [[ -z $dryrun ]] &&
        ln -s ${force} "$curdir/${base}" ${userdir}/${base}
done

cd $OLDPWD

echo

