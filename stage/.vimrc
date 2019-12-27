" vundle setup
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'          " Vundle package manager
Plugin 'tpope/vim-fugitive'         " git integration
Plugin 'rking/ag.vim'               " silversearcher integration
Plugin 'kchmck/vim-coffee-script'   " coffeescript syntax support
Plugin 'scrooloose/nerdtree'        " file tree navigation
Plugin 'tpope/vim-markdown'         " vim markdown plugin
Plugin 'elzr/vim-json'              " json syntax plugin
Plugin 'pangloss/vim-javascript'    " javascript
Plugin 'ntpeters/vim-better-whitespace' " better whitepsace?
Plugin 'rip-rip/clang_complete'     " C++ completion
Plugin 'nvie/vim-flake8'            " Python flake8
Plugin 'oplatek/Conque-Shell'       " Terminals
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'sickill/vim-sunburst'       " Yet more colors eh
Plugin 'isRuslan/vim-es6'           " Because it's like a real language now? =)
Plugin 'octol/vim-cpp-enhanced-highlight' " C++ syntax colors
Plugin 'davidhalter/jedi-vim'       " Maybe autocomplete?
Plugin 'ekalinin/Dockerfile.vim'    " KOOLAID
Plugin 'inkarkat/vim-ingo-library'  " Dependencies, ugh.
Plugin 'inkarkat/vim-spellcheck'    " I guess I'm a human?
Plugin 'rykka/riv.vim'              " Because I like pain.
Plugin 'editorconfig/editorconfig-vim' " Excellent.
Plugin 'deoplete-plugins/deoplete-jedi' " When it works.
Plugin 'vim-syntastic/syntastic'    " I used to hate it, but have come around.
Plugin 'hashivim/vim-terraform'     " Because again, I hate myself.
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

" configure vim-autopep8 to be aggressive
let g:autopep8_max_line_length=79
let g:autopep8_aggressive=2

" configure ongoing spellchecking
set spell spelllang=en_us
let g:SpellCheck_ErrorContextNum = 99

" default editor settings
set background=dark
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
set backspace=indent,eol,start
" special tab settings by file type
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown colorcolumn=100
au BufNewFile,BufFilePre,BufRead *.rst set filetype=markdown colorcolumn=100 nofoldenable
au BufNewFile,BufFilePre,BufRead *.hbs set filetype=hbs
au BufNewFile,BufFilePre,BufRead BUCK set filetype=python colorcolumn=100
au BufNewFile,BufFilePre,BufRead *.jinja set filetype=jinja
au BufNewFile,BufFilePre,BufRead Jenkinsfile set filetype=groovy
au FileType lua,jinja,xml,html,hbs,ant,java,javascript,json,markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2
au Filetype python setlocal colorcolumn=80
" HACK: ensure that jedi can navigate up from within test directories in a
" virtualenv.
au Filetype python python sys.path.append(".")

" Recommended syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" This one nearly killed me. Why did this ever get turned off?
let g:jedi#smart_auto_mappings = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['mypy', 'flake8']
