syntax enable
filetype plugin indent on

" Install for vim-plug
if empty(glob('~/dotfiles/autoload/plug.vim'))
 	silent !curl -fLo ~/dotfiles/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	if empty(glob('~/.vim/autoload/'))
		silent !mkdir ~/.vim/autoload/
	endif
 	silent !ln -s ~/dotfiles/autoload/plug.vim ~/.vim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync | source ~/dotfiles/vimrc
endif

" Plugins
call plug#begin('~/dotfiles/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
call plug#end()

" Color theme
let g:solarized_bold=1
let g:solarized_italic=1
let g:solarized_underline=1
set background=dark
let g:solarized_termtrans=1
colorscheme solarized

" Line numbers
set number
set relativenumber

" Leader key
let mapleader = ","

" vimgrep from project folder using the same file extension as the current.
" buffer
command! -nargs=1 Se execute 'vimgrep /<args>/ **/*.' . expand('%:e')

" Disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" System clipboard
set clipboard=unnamed

" Hide insert status
set noshowmode

" Use tabs
set autoindent noexpandtab tabstop=4 shiftwidth=4

let g:python_highlight_all=1

" Latex compile on save
autocmd BufWritePost *.tex !pdflatex -shell-escape <afile>

" Open NERDtree
nnoremap <Leader>f :NERDTreeToggle<Enter>

" vim-Jedi don't show popup
autocmd FileType python setlocal completeopt-=preview

" Spell check
set spell spelllang=en_us
hi SpellBad ctermbg=LightBlue

" Backspace to work
set backspace=indent,eol,start

" Faster scroll
set ttyfast

let g:UltiSnipsExpandTrigger="<c-j>"

" Lua
autocmd BufNewFile,BufRead *.lua set expandtab
autocmd BufNewFile,BufRead *.lua set tabstop=3

" incremental search
set incsearch
" highlight matches
set hlsearch  

" left space above and under the cursor
set scrolloff=10

" Show all 
set wildmenu

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8'],
\}
