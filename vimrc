execute pathogen#infect()

syntax on

set nocompatible
set cindent
set smartindent
set tabstop=4
set shiftwidth=4 
set softtabstop=4
set expandtab " noexpandtab
"set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#996666
"set textwidth=79
"set wrap
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
"colorscheme base16-parkjinwoo
set background=dark
"set mouse=a

if has("gui_macvim")
  set guifont=Menlo:h16.00
  set transparency=15
  set noimdisable
endif

filetype on
filetype plugin on
filetype indent on

"autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType eruby setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType coffee setlocal tabstop=2 shiftwidth=2 softtabstop=2
"autocmd FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2

"augroup filetypedetect 
"  autocmd! BufRead,BufNewFile *.erb set filetype=eruby
"  autocmd! BufRead,BufNewFile *.coffee set filetype=coffee
"  autocmd! BufRead,BufNewFile *.{md,mkd,markdown} set filetype=markdown 
"augroup END
