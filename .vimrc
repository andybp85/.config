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
" Plugin 'altercation/vim-colors-solarized'
Plugin 'StanAngeloff/php.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'gregsexton/MatchTag'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'burnettk/vim-angular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'wOng/vim-hybridi.git'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-rooter'
" Plugin 'joonty/vim-phpqa'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/dbext.vim'
Bundle 'SirVer/ultisnips'
Bundle 'adamclerk/vim-razor'
Bundle 'joonty/vdebug.git'
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

" switch between panes 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"NERDTree
"map a specific key or shortcut to open NERDTree
map <C-o> :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" hybrid colors
"let g:hybrid_use_iTerm_colors = 1
"colorscheme hybrid

" airline
let g:airline#extensions#tabline#enabled = 1

" statusline
"from https://github.com/spf13/spf13-vim/blob/master/.vimrc
if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=%{fugitive#statusline()} "  Git Hotness
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_enable_signs=1
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Vdebug
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9001

" turn off arrows
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" need for nerdcommentor
filetype plugin on
let mapleader = ","

" smart insert semicolon
inoremap <leader>; <C-o>m`<C-o>A;<C-o>```

" make shell interactive 
:set shellcmdflag=-ic

" tidy
:command Thtml :%!tidy -mqi --doctype omit --show-body-only true --show-warnings no --vertical-space no --wrap 0 --show-errors 0
:command Thtmldoc :%!tidy -mqi --show-warnings no --vertical-space no --wrap 0 --show-errors 0
:command Txml  :%!tidy -mqi --doctype omit --show-body-only true --show-warnings no --vertical-space no --wrap 0 --show-errors 0 -xml

" dbtext: FIFI
let g:dbext_default_profile_mysql_fifi = 'type=MYSQL:user=fifi:passwd=uP9hGSXjteTY2eG9:dbname=FIFI'

" sqlcompletion turn off insanity
let g:omni_sql_no_default_maps = 1

" change the working directory of vim to the directory of the file opened 
set autochdir
