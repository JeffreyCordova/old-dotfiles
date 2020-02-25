#!/bin/bash

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg
cd yay && rm -rf yay

rustup default stable

#---[fix]---------------
yay -S $(cat deps/deps-cli)
#-----------------------
