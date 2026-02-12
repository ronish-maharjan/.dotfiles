#!/bin/bash
# You should first install fd the finder which is faster than find (old one)
ROOT="$HOME"

# Folders to exclude (easily editable)
EXCLUDES=("node_modules" ".git")

# Build the --exclude flags for fd
EXCLUDE_FLAGS=()
for folder in "${EXCLUDES[@]}"; do
    EXCLUDE_FLAGS+=(--exclude "$folder")
done

# Run fd + fzf
FILE=$(fd . "$ROOT" --type f --hidden "${EXCLUDE_FLAGS[@]}" | fzf --height 40% --reverse --border --prompt="ff> ")

# If a file was selected
if [ -n "$FILE" ]; then
    DIR=$(dirname "$FILE")
    cd "$DIR" || exit
    nvim "$FILE"
fi
