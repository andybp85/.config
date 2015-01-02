" set term=builtin_ansi
set number
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set copyindent " copy the previous indentation on autoindenting
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch " set show matching parenthesis
set smartcase " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch " highlight search terms
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
set incsearch " show search matches as you type


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


" Filesystem
Plugin 'scrooloose/nerdtree'
Bundle 'twe4ked/vim-peepopen'
Plugin 'airblade/vim-rooter'
Bundle 'kien/ctrlp.vim'

" auto suggest and syntaxt checked
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'

" text editing plugins
Plugin 'gregsexton/MatchTag'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular' "http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plugin 'csexton/trailertrash.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'

" undo tree editor
Plugin 'sjl/gundo.vim'

" git 
Plugin 'tpope/vim-fugitive'

" snippits
Plugin 'SirVer/ultisnips'

"status line
Plugin 'bling/vim-airline'

" buffers 
Plugin 'jeetsukumaran/vim-buffergator'

" debugging
Bundle 'joonty/vdebug.git'

" lang specific
Plugin 'adamclerk/vim-razor'
Plugin 'hylang/vim-hy'
Plugin 'claco/jasmine.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'burnettk/vim-angular'
Plugin 'StanAngeloff/php.vim'
Plugin 'plasticboy/vim-markdown'
Bundle "pangloss/vim-javascript"

" color schemes
"Plugin 'flazz/vim-colorschemes'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'croaker/mustang-vim'



"all of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

syntax on

"solarized dark theme
"if has('gui_running')
  "set background=dark
  "colorscheme solarized
"endif

" mustang them
if &t_Co >= 256 || has("gui_running")
    colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

"disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"highlight color for youcompleteme
highlight Pmenu ctermfg=0 ctermbg=4 guifg=#ffffff guibg=#0000ff 

"NERDTree
"open a NERDTree automatically when vim starts up if no files were specified
" autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif ""
"map a specific key or shortcut to open NERDTree
map <C-o> :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" block keyboard keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0

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

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" change the mapleader from \ to ,
let mapleader=","

" maps the ,ev and ,sv keys to edit/reload .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" highlight whitespace
" set list
" set listchars=tab:>.,trail:.,extends:#,nbsp:.
" autocmd filetype html,xml set listchars-=tab:>.

" TrailorTrash coloring
hi UnwantedTrailerTrash guibg=black ctermbg=black

" don't jump lines
nnoremap j gj
nnoremap k gk

" strip shift from write, use ;w
nnoremap ; :

set pastetoggle=<F2>

" whenever you type % you jump to the matching object, and you visually select all the text in between
noremap % v%

" add sudo with :w!!
cmap w!! w !sudo tee % >/dev/null

" default command to invoke CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Exclude files and directories
set wildignore+=*/tmp/*,*.so,*.swp,*.zip  

" xmllint with @@x
map @@x !%xmllint --format --recover -^M

" make python prog
:set makeprg=python\ %

