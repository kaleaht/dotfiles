syntax on
filetype plugin indent on
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
" Use tabs
set autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=4


" Add [""]
nnoremap ," ciw[""]<Esc>p

" Install for vim-plug
if empty(glob('~/dotfiles/autoload/plug.vim'))
 	silent !curl -fLo ~/dotfiles/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	if empty(glob('~/.vim/autoload/'))
		silent !mkdir ~/.vim/autoload/
	endif
 	silent !ln -s ~/dotfiles/autoload/plug.vim ~/.vim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync | source ~/dotfiles/vimrc
endif

"set path+=,/court/arm/include/QtCore

" Plugins
call plug#begin('~/dotfiles/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'airblade/vim-gitgutter'
"Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor
	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :Ag! <C-R><C-W><CR>:cw<CR>
"nnoremap K :Ag <C-R><C-W><CR>
nnoremap \ :Ag<CR>

" Colors
set t_Co=16
set background=dark
colorscheme solarized


" Line numbers
set number
set relativenumber

" Leader key
let mapleader = ","

nnoremap <leader>e :Files<CR>

" vimgrep from project folder using the same file extension as the current.
" buffer
command! -nargs=1 Se execute 'vimgrep /<args>/ **/*.' . expand('%:e')

" Disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" System clipboard
"set clipboard=unnamed

" Hide insert status
"set noshowmode

let g:python_highlight_all=1

" Latex compile on save
autocmd BufWritePost *.tex !pdflatex -shell-escape <afile>

" Open NERDtree
nnoremap <Leader>f :NERDTreeToggle<Enter>

" vim-Jedi don't show popup
"autocmd FileType python setlocal completeopt-=preview

" Spell check
"set spell spelllang=en_us
"hi SpellBad ctermbg=LightGray

" Backspace to work
set backspace=indent,eol,start

" Faster scroll
set ttyfast

let g:UltiSnipsExpandTrigger="<c-j>"

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation.
nmap <leader>gh :CocCommand clangd.switchSourceHeader<Enter>
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart


" incremental search
set incsearch
" highlight matches
set hlsearch

" left space above and under the cursor
set scrolloff=10

" Show all
"set wildmenu

" ALE
"let g:ale_fixers = {
"\   '*': ['remove_trailing_lines', 'trim_whitespace'],
"\   'python': ['autopep8'],
"\}

let g:ale_completion_enabled = 1
"set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_linters = {'cpp': ['gcc']}

let g:ale_cpp_gcc_options = '-std=c++14 -Wall -I /court/arm/include/QtCore -I /court/arm/include -I /home/ahti/work/courtiusgroup/devices/trueline/gpu_shared'

" Language-specific stuff from your .vimrc file into a file named
" .vim/ftplugin/language.vim
filetype plugin on

"let g:ycm_global_ycm_extra_conf = '~/dotfiles/.ycm_extra_conf.py'

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

let g:go_fmt_command = "goimports"
