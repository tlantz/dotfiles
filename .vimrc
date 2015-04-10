filetype plugin indent on
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set number 
set ruler
set hlsearch
au FileType xml,html,ant setlocal tabstop=2 shiftwidth=2
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
    set background=dark
endif
