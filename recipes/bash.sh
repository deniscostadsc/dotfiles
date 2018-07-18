#!/bin/bash

kickstart.file.append_once() {
    if ! kickstart.file.contains "$1" "$2"; then
        echo "$2" >> "$1"
    fi
}

kickstart.file.append_file_once() {
    file_to_append=$1
    destiny_file=$2

    if ! kickstart.file.contains "$destiny_file" "$file_to_append"; then
        {
            echo
            echo "# $file_to_append - appended by kickstart"
            echo
            cat "$file_to_append"
        } >> "$destiny_file"
    fi
}

kickstart.file.append_all_bashrc_files() {
    bashrc_files=$(find .. -name 'bashrc_*')

    for bashrc_file in $bashrc_files; do
        kickstart.file.append_file_once "$bashrc_file" $HOME/.bashrc
    done
}

kickstart.file.mkdir_and_chown() {
    kickstart.mute mkdir -p "$1" || true
    kickstart.mute chown "$USER:$USER" -R "$2"
}
