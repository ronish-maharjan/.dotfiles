#!/bin/bash

CONFIG="$HOME/.config"
BIN="$HOME/.local/bin"

mkdir -p "$CONFIG" "$BIN"

install_link() {
    local source="$1"
    local target="$2"

    if [[ -e "$target" || -L "$target" ]]; then

        # Already linked correctly
        if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
            echo "Already linked: $target"
            return
        fi

        read -rp "$target already exists. Replace it? [y/N] " answer

        case "$answer" in
            y|Y)
                rm -rf "$target"
                ;;
            *)
                echo "Skipped: $target"
                return
                ;;
        esac
    fi

    ln -s "$source" "$target"
    echo "Linked: $target"
}


echo "Installing dotfiles..."
echo

install_link \
    "$PWD/.config/nvim" \
    "$CONFIG/nvim"

install_link \
    "$PWD/.config/i3" \
    "$CONFIG/i3"

install_link \
    "$PWD/.config/i3status" \
    "$CONFIG/i3status"

install_link \
    "$PWD/.config/tmux" \
    "$CONFIG/tmux"

install_link \
    "$PWD/.bashrc" \
    "$HOME/.bashrc"

install_link \
    "$PWD/.xinitrc" \
    "$HOME/.xinitrc"

install_link \
    "$PWD/bin/app-opener" \
    "$BIN/app-opener"

echo
echo "Done."
