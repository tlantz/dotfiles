" vundle setup
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'          " Vundle package manager
Plugin 'tpope/vim-fugitive'         " git integration
Plugin 'rking/ag.vim'               " silversearcher integration
Plugin 'scrooloose/nerdtree'        " file tree navigation
Plugin 'tpope/vim-markdown'         " vim markdown plugin
Plugin 'elzr/vim-json'              " json syntax plugin
Plugin 'pangloss/vim-javascript'    " javascript
Plugin 'ntpeters/vim-better-whitespace' " better whitepsace?
Plugin 'rip-rip/clang_complete'     " C++ completion
Plugin 'nvie/vim-flake8'            " Python flake8
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
Plugin 'juliosueiras/vim-terraform-completion'  "Such a long name!
Plugin 'hiphish/jinja.vim'          " Please work well.
Plugin 'dhruvasagar/vim-table-mode' " Column width nuttiness needs help now.
Plugin 'sbdchd/neoformat'           " Neoformat, to use with ocamlformat
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
" So we stop getting maxmempattern for rst link patterns, default is 1000
set mmp=2000
" special tab settings by file type
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown colorcolumn=100
au BufNewFile,BufFilePre,BufRead *.rst set filetype=rst colorcolumn=100 nofoldenable
au BufNewFile,BufFilePre,BufRead *.hbs set filetype=hbs
au BufNewFile,BufFilePre,BufRead BUCK set filetype=python colorcolumn=100
au BufNewFile,BufFilePre,BufRead *.jinja set filetype=jinja
au BufNewFile,BufFilePre,BufRead Jenkinsfile set filetype=groovy
au FileType lua,jinja,xml,html,hbs,ant,java,javascript,json,markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2
au Filetype python setlocal colorcolumn=80
au FileType rst setlocal tabstop=3 shiftwidth=3 softtabstop=3 spell
au Filetype rst syntax spell toplevel
" HACK: ensure that jedi can navigate up from within test directories in a
" virtualenv.
au Filetype python python3 sys.path.append(".")

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
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["rst"] }

" Hoaky setup for local vimrcs for repo based spellfiles. Need to figure out
" something better in the future.
if filereadable(expand("~/.vim/lvimrc.whitelist"))
    let g:localvimrc_sandbox = 0
    source ~/.vim/lvimrc.whitelist
endif

" From
" https://ocaml.org/p/ocamlformat/0.22.4/doc/editor_setup.html#vim-setup
let g:opambin = substitute(system('opam config var bin'),'\n$','','''')
let g:neoformat_ocaml_ocamlformat = {
            \ 'exe': g:opambin . '/ocamlformat',
            \ 'no_append': 1,
            \ 'stdin': 1,
            \ }

let g:neoformat_enabled_ocaml = ['ocamlformat']

" From
" https://stackoverflow.com/questions/20979403/adding-number-of-lines-in-file-to-vim-status-bar
set statusline =%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor
