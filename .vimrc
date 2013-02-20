set nocompatible
set cindent
set smartindent
set tabstop=4
set shiftwidth=4 
set softtabstop=4
set expandtab " noexpandtab
"set textwidth=79
"set wrap
set hlsearch
set incsearch
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
set syntax=on
"colorscheme default
"set background=dark
"set mouse=a

filetype on
filetype plugin on
filetype indent on

au FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2
au FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
au FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
