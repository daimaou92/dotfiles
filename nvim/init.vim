" true color support
if (has("nvim"))
	if (has("termguicolors"))
		set termguicolors
	endif
endif

" Plugins (vim-plug)
call plug#begin('~/.vim/plugged')
	Plug 'neovim/nvim-lspconfig'
	Plug 'simrat39/rust-tools.nvim'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'onsails/lspkind-nvim'
	Plug 'nvim-lua/lsp_extensions.nvim'
	Plug 'glepnir/lspsaga.nvim'
	Plug 'simrat39/symbols-outline.nvim'
	" MarkdownPreview
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

	" treesitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/playground'

	" snippets
	Plug 'L3MON4D3/LuaSnip'
	Plug 'rafamadriz/friendly-snippets'

	" program helpers
	Plug 'rust-lang/rust.vim'
	" To enable more of the features of rust-analyzer, such as inlay hints and more!
	Plug 'simrat39/rust-tools.nvim'

	" Plug 'darrikonn/vim-gofmt'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
	Plug 'junegunn/gv.vim'
	Plug 'mbbill/undotree'

	" telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim'

	" prettier
	Plug 'sbdchd/neoformat'

	" Others
	Plug 'mhinz/vim-startify'
	Plug 'gruvbox-community/gruvbox'
	Plug 'preservim/vim-colors-pencil'
	Plug 'crispgm/nvim-tabline'
	Plug 'itchyny/lightline.vim'
call plug#end()

" syntax highlighting off
" syntax off

lua require("daimaou92")
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

let loaded_matchparen = 1
let mapleader = " "

let g:neoformat_enabled_go = ['goimports']

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" close all but current buffer
nnoremap <leader>co :BufOnly<CR>

" markdown-preview mappings
nnoremap <C-s> :MarkdownPreview<CR>
nnoremap <M-s> :MarkdownPreviewStop<CR>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup DAIMAOU92
    autocmd!
    " autocmd BufWritePre lua,cpp,c,h,hpp,cxx,cc Neoformat
	" autocmd BufWritePre * undojoin | Neoformat
	autocmd BufWritePre * Neoformat
	autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup cursorline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline cursorcolumn
  autocmd WinLeave,BufLeave * setlocal nocursorline nocursorcolumn
augroup END
