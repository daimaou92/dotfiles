set encoding=utf8
set incsearch       " search as characters are entered
set nohlsearch      " don't highlight matches
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set clipboard+=unnamedplus
set hidden
set nobackup
set noswapfile
set undodir=~/.vim/undodir
set undofile
set number
set relativenumber
set showcmd
set showmatch
set laststatus=2
set statusline+=%F
set lazyredraw
set scrolloff=8
set noshowmode
set noerrorbells
set colorcolumn=80
set signcolumn=yes
set updatetime=50
set isfname+=@-@
set confirm

" more space for displaying messages
set cmdheight=1

" Avoid showing extra messages when using completion
set shortmess+=c

set wildmode=longest,list,full
set wildmenu

" open new split panes to right and below (as you probably expect)
set splitright
set splitbelow

set path+=**

" Ignore file patterns
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" Copy to clipboard
set clipboard+=unnamedplus
