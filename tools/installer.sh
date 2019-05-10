#!/bin/bash
get_tag_from_extension() {
    extension="$1";
    exclude_path_from_tag="$2";
    echo  $extension | sed -e "s|$exclude_path_from_tag||g" | sed -e "s/[0-9]_//g" -e "s/\//-/g" -e "s/\.sh$//";
}
get_exclude_path() {
    exclude_path_from_tag="";
    if [ -n "${1}" ]; then
        exclude_path_from_tag="$1";
    fi
    echo $exclude_path_from_tag;
}
get_installer_option() {
    option="$1";
    all_tags="$2";
    if [  -z "$(echo "$1"|sed "/ultimate/d")" ]; then
        option="$all_tags";
    fi;
    echo $option
}
extensions_path="$2";
exlude_path_from_name="$3";
installation_tag="$1";
echo "Installer";
extensions=$(find "$extensions_path" -type f -print0 | sort -z | xargs -r0);
echo "Extensions: $extensions";
tags="";
option="minimal";
exclude_path_from_tag="$(get_exclude_path "$exlude_path_from_name")";
for extension in $extensions; do
    tag="$(get_tag_from_extension "$extension" "$exclude_path_from_tag")";
    tags="$tags,$tag";
done
tags="${tags:1}";
echo "Available tags: $tags";
if [ -n "${installation_tag}" ]; then
    option="$(get_installer_option "$installation_tag" $tags)";
    echo "Installation tags: $option";
    for extension in $extensions; do
        tag="$(get_tag_from_extension "$extension" "$exclude_path_from_tag")";
        echo "Checked tag: $tag";
        if [ -z "$(echo "$option"|sed "/$tag/d")" ]; then
            echo "Installing: $tag";
            /bin/ash $extension;
        fi
    done
fi;
