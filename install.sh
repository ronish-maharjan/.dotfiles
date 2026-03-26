#!/bin/bash

# remove existing real dirs/files first
rm -rf ~/.config/nvim
rm -rf ~/.config/i3
rm -rf ~/.config/i3status
rm -rf ~/.config/tmux
rm -f ~/.bashrc
rm -f ~/.local/bin/tmux-sessionizer

# now create clean symlinks
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/.config/i3 ~/.config/i3
ln -sf ~/.dotfiles/.config/i3status ~/.config/i3status
ln -sf ~/.dotfiles/.config/tmux ~/.config/tmux
ln -sf ~/.dotfiles/.config/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/bin/tmux-sessionizer ~/.local/bin/tmux-sessionizer

echo "done"
