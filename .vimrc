set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" vundle setup
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"Plugin 'tpope/fugitive.vim'
call vundle#end()
" default editor settings
filetype plugin indent on
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set number 
set ruler
set hlsearch
set colorcolumn=101
" xml, html settings
au FileType xml,html,ant setlocal tabstop=2 shiftwidth=2
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
    set background=dark
endif

