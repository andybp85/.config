#!/bin/bash

rm -f ~/.bashrc
ln -s ~/.config/.bashrc ../.bashrc
ln -s ~/.config/.bash_aliases ../.bash_aliases
mkdir ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
rm -f ~/.vimrc
ln -s ~/.config/.vimrc ~/
vim +PluginInstall +qall
vim +BundleInstall +qall
