syntax on

set nocompatible
set cindent
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4 
set softtabstop=4
set expandtab " noexpandtab
"set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#996666
"set textwidth=79
set nowrap " wrap
set hlsearch
set incsearch
"set ingnorecase
"set cursorline
"set modeline
set showmatch
set backspace=eol,start,indent
set ruler
"set number
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp949,korea,iso-2022-kr,latin1
set fileencoding=utf-8
set termencoding=utf-8
"set fileformat=unix
set history=1000
set undolevels=1000
"set mouse=a
set termguicolors
set background=dark
"colorscheme default

filetype on
filetype plugin on
filetype indent on

"autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2

"augroup filetypedetect
"  autocmd! BufRead,BufNewFile *.{md,mkd,markdown} set filetype=markdown 
"augroup END
