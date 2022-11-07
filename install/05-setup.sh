#!/bin/bash

# set up tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux

ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf
cp ~/.tmux.conf.local ~
