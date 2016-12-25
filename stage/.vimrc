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
Plugin 'ntpeters/vim-better-whitespace' " better whitepsace?
Plugin 'rip-rip/clang_complete'     " C++ completion
Plugin 'nvie/vim-flake8'            " Python flake8
Plugin 'oplatek/Conque-Shell'       " Terminals
Plugin 'flazz/vim-colorschemes'     " Color schemes
Plugin 'atweiden/vim-colors-behelit' " Colors
Plugin 'sickill/vim-sunburst'       " Yet more colors eh
Plugin 'isRuslan/vim-es6'           " Because it's like a real language now? =)
Plugin 'octol/vim-cpp-enhanced-highlight' " C++ syntax colors
call vundle#end()
" get OS name
let os = substitute(system('uname'), "\n", "", "")
let g:vim_json_syntax_conceal = 0   " turn off quote hiding for json
" set path to clang frontend library for OSX
if os == "Darwin"
    let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
elseif os == "Linux"
    let g:clang_library_path = '/usr/lib/x86_64-linux-gnu/libclang.so.1'
endif

" default editor settings
colors gruvbox
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
au BufNewFile,BufFilePre,BufRead *.jinja set filetype=jinja
au FileType lua,jinja,xml,html,hbs,ant,java,scala,javascript,json,markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2

