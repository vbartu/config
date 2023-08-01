#! /usr/bin/bash

for DIR in */
do
    DIR=$(echo $DIR | sed 's/\///g') # Remove any '/'
    if echo $DIR | grep "\-meta$" &>/dev/null; then
        echo "Installing $DIR"
        cd $DIR
        makepkg -si
        cd ..
    fi
done
