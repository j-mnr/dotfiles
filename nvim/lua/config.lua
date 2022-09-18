vim.api.nvim_create_autocmd(
  { 'FocusLost', 'BufWinLeave', 'BufLeave', 'WinLeave', 'TabLeave' }, {
  group = vim.api.nvim_create_augroup('saveOnLoseFocus', {}),
  pattern = { '*' },
  command = 'silent! update'
})
vim.api.nvim_create_autocmd(
  { 'TextYankPost' }, {
  pattern = { '*' },
  command = 'silent! lua vim.highlight.on_yank { timeout = 250 }',
})

local ws = vim.api.nvim_create_augroup('whitespace', {})
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'InsertLeave' }, {
  group = ws,
  pattern = { '*' },
  command = 'match NvimInternalError /\\s\\+$/',
})
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  group = ws,
  pattern = { '*' },
  command = 'match NvimInternalError /\\s\\+\\%#\\@<!$/',
})
vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  group = ws,
  pattern = { '*' },
  command = 'call clearmatches()',
})

local o = vim.opt
-- Global config
o.compatible = false
o.swapfile = false
o.undofile = true
o.undodir = '/tmp'
o.autowriteall = true
o.autoread = true
o.gdefault = true
o.virtualedit = { 'onemore', 'block' }
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
o.foldlevelstart = 1
o.foldmethod = 'indent'
o.foldexpr = 'nvim_treesitter#foldindent()'
-- UX
o.termguicolors = true
o.number = true
o.numberwidth = 1
o.ruler = true
o.signcolumn = 'yes'
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

-- TODO put these somewhere
o.completeopt = 'menu,menuone,noselect'
o.updatetime = 100

o.autoindent = true
o.smartindent = true
-- o.cindent = true
