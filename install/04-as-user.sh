#!/bin/bash

git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin && makepkg
cd .. && rm -rf paru-bin

rustup default stable

#---[fix]---------------
yay -S $(cat deps/deps-cli)
#-----------------------
