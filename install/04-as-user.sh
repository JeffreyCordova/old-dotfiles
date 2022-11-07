#!/bin/bash

rustup default stable

git clone https://aur.archlinux.org/paru.git
cd paru && makepkg
cd .. && rm -rf paru

