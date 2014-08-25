set term=builtin_ansi
set number
set tabstop=4
set shiftwidth=4
set expandtab

"execute pathogen#infect()

set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"Plugin 'https://github.com/Valloric/YouCompleteMe'
Plugin 'https://github.com/scrooloose/syntastic'
Plugin 'https://github.com/sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'plasticboy/vim-markdown'

"all of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

syntax on

" disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


