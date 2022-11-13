#!/bin/bash

# tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux

ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf
cp ~/.tmux/.tmux.conf.local ~

# NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

