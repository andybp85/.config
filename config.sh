#!/bin/bash

rm -f ~/.bash_profile
ln -s ~/.config/.bash_profile ~/  
rm -f ~/.bashrc
ln -s ~/.config/.bashrc ~/
rm -rf ~/.vim
ln -s ~/.config/.vim ~/
rm -f ~/.vimrc
ln -s ~/.config/.vimrc ~/

