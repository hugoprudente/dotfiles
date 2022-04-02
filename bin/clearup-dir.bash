#!/usr/bin/env bash
#
#Clear up my $DIR directory fetching files by extensions.

#Autor: Hugo Prudente

#
# --------------------------------------------------------------
# Looks for files with the same extension fetching into directories making clear and pretty
# --------------------------------------------------------------
#
#@ History:
#@ v0.1 - 2009/02/05 - Hugo Prudente:
#@   Creating this file
#@ v0.2 - 2016/10/10 - Hugo Prudente:
#@   Developing the rules
#@ v0.3 - 2022/01/16 - Hugo Prudente:
#@   Adding new rules due to find not working wheel on WSL
#@ v0.4 - 2022/04/02 - Hugo Prudente:
#@   Add support for files with "space" in the name for WSL
# [ GLOBAL ]
#
HELP="
$(basename $0) [options] absolutepath

Options:

-V  Script version
-h  Script help
-H  Revision history $(basename $0)
"
#
# [ FUNCTIONS ]
#

#
# [ OPTIONS MENU ]
# Options Menu ./$0 -h -V -H
#

while getopts ":VhH" opcao
do
    case $opcao in
    V)
        echo "Version: `grep "v\([0-9].[0-9]\)" "$0" |\
        tail -1 | cut -d "-" -f 1 | tr -d \#`"
        exit 0
        ;;
    h)
        echo "$HELP"
        exit 0
        ;;
    H)
        grep "#@" "$0" | less
        exit 0
        ;;
    *)
        if [ ! -z $opcao ];then
            exit 0
            fi
        ;;
    esac
done

#
# [ DESENVOLVIMENTO ]
#

if [ -z $1 ];then
    echo -e "error: absolute path is missing"
    echo "$HELP"
    exit 1
fi

cd $1
pwd
for file in *.???;do
    [ -f "$file" ] || continue
    dir=$(echo "$file" | rev | cut -c-3 | rev)
    [ -d "$dir" ] || mkdir -p "$dir" || { echo "Couldn't mkdir -p $dir; already exist" ; }
    echo mv -- "$file" "$dir"
done

for file in *.????;do
    [ -f "$file" ] || continue
    dir=$(echo "$file" | rev | cut -c-4 | rev)
    [ -d $dir ] || mkdir -p "$dir" || { echo "Couldn't mkdir -p $dir; already exist" ; }
    echo mv -- "$file" "$dir"
done

