#!/bin/bash

rm -f ~/.bash_profile
ln -s .bash_profile ~/  
rm -f ~/.bashrc
ln -s .bashrc ~/
rm -rf ~/.vim
ln -s .vim ~/
rm -f ~/.vimrc
ln -s .vimrc ~/

