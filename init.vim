" Basic editor configuration
syntax on
filetype on
filetype plugin indent on
filetype plugin on
set mouse=a
set termguicolors
set omnifunc=syntaxcomplete#Complete

set hidden
set nowrap
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set expandtab
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

" Increase history for UNDO and REDO commands
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells

" Don't let VIM from writing a backup file
set nobackup
set noswapfile

" VIM Paste mode, use it to paste from system clipboard
set pastetoggle=<F2>

" Airline plugin configuration
set laststatus=2

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='dark'


call plug#begin()
Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'brooth/far.vim'
Plug  'dracula/vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'itchyny/lightline.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'phanviet/vim-monokai-pro'
Plug 'raichoo/purescript-vim'
Plug 'frigoeu/psc-ide-vim'
Plug 'vim-syntastic/syntastic'
Plug 'ayu-theme/ayu-vim'
call plug#end()

colorscheme ayu 
