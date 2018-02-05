syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let vundle manage vundle
 Plugin 'gmarik/vundle'

" list all plugins that you'd like to install here
 Plugin 'kien/ctrlp.vim' " fuzzy find files
 Plugin 'benmills/vimux'
 Plugin 'tpope/vim-surround'
 Plugin 'christoomey/vim-tmux-navigator'
 Plugin 'scrooloose/nerdtree'

 " Python
 Plugin 'davidhalter/jedi-vim'
 Plugin 'vim-python/python-syntax'
 Plugin 'wilywampa/vim-ipython' " Not working
 Plugin 'nvie/vim-flake8'
 Plugin 'tell-k/vim-autopep8'

 " Comments
 Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on

colorscheme desert

" Line numbers
set number
set relativenumber

" Leader key
let mapleader = ","

" Disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" noremap  <Up> ""
" noremap! <Up> <Esc>
" noremap  <Down> ""
" noremap! <Down> <Esc>
" noaemap  <Left> ""
" noremap! <Left> <Esc>
" noremap  <Right> ""
" noremap! <Right> <Esc>

" system clipboard
set clipboard=unnamed

" use tabs
set autoindent noexpandtab tabstop=4 shiftwidth=4

" latex
let g:livepreview_previewer = 'evince'
let g:livepreview_engine = 'pdflatex'

let g:python_highlight_all = 1
" set colorcolumn=80
