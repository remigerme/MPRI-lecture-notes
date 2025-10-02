compile_folder() {
    root="$1"
    folder="$2"
    for source in "$folder"/*.typ; do
        typst compile "$source" --root="$root"
    done
}

compile_folder $1 $2
