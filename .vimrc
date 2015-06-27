" vundle setup
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'          " Vundle package manager
Plugin 'tpope/vim-fugitive'         " git integration
Plugin 'rking/ag.vim'               " silversearcher integration
Plugin 'derekwyatt/vim-scala'       " scala syntax support
Plugin 'kchmck/vim-coffee-script'   " coffeescript syntax support
Plugin 'scrooloose/nerdtree'        " file tree navigation
Plugin 'tpope/vim-markdown'         " vim markdown plugin
Plugin 'elzr/vim-json'              " json syntax plugin
Plugin 'pangloss/vim-javascript'    " javascript
let g:vim_json_syntax_conceal = 0   " turn off quote hiding for json
call vundle#end()
" default editor settings
filetype plugin indent on
syntax on
" key bindings
map <C-n> :NERDTreeToggle<CR>       " launch file browser
" default settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number 
set ruler
set hlsearch
" special tab settings by file type
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufNewFile,BufFilePre,BufRead *.hbs set filetype=hbs
au BufNewFile,BufFilePre,BufRead BUCK set filetype=python
au FileType xml,html,hbs,ant,java,scala,javascript,json,markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2
let atwork = $ATWORK
if atwork == "YEP"
    " non-standard python tabbing for work
    au FileType python setlocal tabstop=2 shiftwidth=2 softtabstop=2
endif
" one off for better color scheme for home desktop
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
    set background=dark
endif

