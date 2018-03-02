syntax enable
filetype plugin indent on

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

" Disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Airline symbols
let g:airline_powerline_fonts=1

" noremap  <Up> ""
" noremap! <Up> <Esc>
" noremap  <Down> ""
" noremap! <Down> <Esc>
" noaemap  <Left> ""
" noremap! <Left> <Esc>
" noremap  <Right> ""
" noremap! <Right> <Esc>

" System clipboard
set clipboard=unnamed

" Hide insert status
set noshowmode

" Use tabs
set autoindent noexpandtab tabstop=4 shiftwidth=4

let g:python_highlight_all=1

" Open NERDtree
nnoremap <Leader>f :NERDTreeToggle<Enter>

" Spell check
set spell spelllang=en_us
hi SpellBad cterm=underline ctermfg=red

" vim-Jedi don't show popup
autocmd FileType python setlocal completeopt-=preview
