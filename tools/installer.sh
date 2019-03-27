#!/bin/bash
echo "Installer";
extensions=$(find "$2" -type f -print0 | sort -z | xargs -r0);
tags="";
option="minimal";
exclude_path_from_tag="";
if [ -n "${3}" ]; then
    exclude_path_from_tag="$3";
fi
for extension in $extensions; do
    tag="$(echo "${extension/$exclude_path_from_tag/}" | sed -e "s/[0-9]_//g" -e "s/\//-/g" -e "s/\.sh$//")";
    tags="$tags,$tag";
done
tags="${tags:1}";
echo "Available tags: $tags";
if [ -n "${1}" ]; then
    if [  -z "$(echo "$1"|sed "/ultimate/d")" ]; then
        option="$tags";
    fi;
    echo "Installing tags: $option";
    for extension in $extensions; do
        tag="$(echo "${extension/$exclude_path_from_tag/}" | sed -e "s/[0-9]_//g" -e "s/\//-/g" -e "s/\.sh$//")";
        echo "Installed tag: $tag";
        if [ -z "$(echo "$option"|sed "/$tag/d")" ]; then
            echo "Installing $tag";
            /bin/ash $extension;
        fi
    done
fi;
