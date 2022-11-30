#!/bin/bash

# tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux

ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf
cp ~/.tmux/.tmux.conf.local ~

# NvChad
git clone https://github.com/NvChad/NvChad ~/dotfiles/nvchad/.config/nvim --depth 1 && nvim

# Rofi
git clone --depth=1 https://github.com/adi1090x/rofi.git ~/rofi

cd ~/rofi
chmod +x setup.sh

./setup.sh

