#!/bin/bash

compile_folder() {
    root="$1"
    folder="$2"
    for source in "$folder"/*.typ; do
        typst compile "$source" --root="$root"
    done
}

watch_folder() {
    root="$1"
    folder="$2"
    for source in "$folder"/*.typ; do
        timeout 3h nohup typst watch "$source" --root="$root" > /dev/null 2>&1 &
    done
}

if [ "$#" -eq 2 ]; then
    compile_folder $1 $2
elif [ "$#" -eq 3 ]; then
    watch_folder $1 $2
else
    echo "Illegal number of parameters (2: compile, 3: watch)"
fi
