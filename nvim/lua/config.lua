vim.cmd 'syntax enable'
vim.cmd 'filetype plugin on'
vim.cmd 'filetype indent on'
vim.cmd 'colorscheme monokai'

local o = vim.opt
-- Global config
o.compatible = false
o.swapfile = false
o.undofile = true
o.undodir = '/tmp'
o.autowriteall = true
o.autoread = true
o.gdefault = true
o.virtualedit = 'all'
-- Windows
o.splitright = true
o.splitbelow = true
-- Tabs and spaces
o.expandtab = true
o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2
-- Folds
o.foldnestmax = 3
o.foldmethod = 'indent'
o.foldexpr = 'nvim_treesitter#indent()'
-- UX
o.number = true
o.numberwidth = 1
o.ruler = true
o.signcolumn = 'number'
o.cursorline = true
o.showcmd = true
o.laststatus = 2
o.textwidth = 79
o.colorcolumn = '+1'
o.list = true
o.listchars = 'space:·,tab:> ,trail:-,extends:>,precedes:<'
o.showmatch = true
o.lazyredraw = true

-- Searching
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.path = '.,,**'
o.wildmenu = true

o.termguicolors = true

-- o.updatetime = 100
-- o.smartindent = true
