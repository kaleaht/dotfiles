syntax enable
filetype plugin indent on

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
:command -nargs=1 Se execute 'vimgrep /<args>/ **/*.' . expand('%:e')

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

" Syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
set is

" left space above and under the cursor
set scrolloff=10

" Show all 
set wildmenu
