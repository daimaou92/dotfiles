vim.opt.encoding = "utf8"
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = false
vim.opt.shiftwidth=4
vim.opt.clipboard:append('unnamedplus')
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. '/.vim/undodir'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.statusline:append('%F')
vim.opt.lazyredraw = true
vim.opt.scrolloff = 8
vim.opt.errorbells = false
vim.opt.colorcolumn = '85'
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50
vim.opt.confirm = true
vim.opt.cmdheight = 1
vim.opt.wildmode = {'longest', 'list', 'full'}
vim.opt.wildmenu = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.backupdir = os.getenv("HOME") .. "/.vim"
vim.opt.path:append('**')
vim.opt.wildignore:append ('*.pyc', '*_build/*', '**/coverage/*', '**node_modules/*',
'**/android/*', '**ios/*', '**/.git/*')
