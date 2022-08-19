vim.cmd [[
function! GoToJson() range abort
  " TODO Make this work for values larger than two aka `ThreeTimesField int`
  let currline = a:firstline
  while currline <= a:lastline
    if getline(currline) =~# '\v(.*(<\u+>).*)'
      execute currline . 's/\v(.*(<\u+>).*)/\1 `json:"\L\2"`/e'
    else
      execute currline . 's/\v(.*(<\u\w+).*)/\1 `json:"\l\2"`/e'
    endif
    execute currline . 's/\v(`json:"\l+)(\u+)(.*)/\1_\L\2\3/e'
    let currline += 1
  endwhile
endfunction
]]

vim.api.nvim_create_autocmd(
  { 'FocusLost', 'BufWinLeave', 'BufLeave', 'WinLeave', 'TabLeave' }, {
  group = vim.api.nvim_create_augroup('saveOnLoseFocus', {}),
  pattern = { '*' },
  command = 'silent! update'
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

vim.api.nvim_set_var('go_metalinter_autosave', 1)

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

-- o.smartindent = true
-- o.cindent = true
