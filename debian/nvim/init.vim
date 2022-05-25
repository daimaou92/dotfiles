" true color support
if (has("nvim"))
	if (has("termguicolors"))
		set termguicolors
	endif
endif

" Install Plugins
call plug#begin()
	" Telescope
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'kyazdani42/nvim-web-devicons'

	" LSP
	Plug 'neovim/nvim-lspconfig'
	
	" Completion
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-nvim-lua'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'onsails/lspkind.nvim'
	
call plug#end()

lua require("daimaou92")


" temp =========
nnoremap <SPACE> <Nop>
let mapleader=" "
" ==============
