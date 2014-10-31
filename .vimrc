set term=builtin_ansi
set number
set tabstop=2
set shiftwidth=2
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

Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'claco/jasmine.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'plasticboy/vim-markdown'
Plugin 'gregsexton/MatchTag'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'burnettk/vim-angular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Bundle "pangloss/vim-javascript"
Bundle 'twe4ked/vim-peepopen'


"all of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

syntax on

"solarized dark theme
if has('gui_running')
  set background=dark
  colorscheme solarized
endif

"disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"highlight color for youcompleteme
highlight Pmenu ctermfg=0 ctermbg=4 guifg=#ffffff guibg=#0000ff 

"NERDTree
"open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif ""
"map a specific key or shortcut to open NERDTree
map <C-o> :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
