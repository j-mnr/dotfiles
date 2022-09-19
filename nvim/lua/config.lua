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

vim.api.nvim_set_var('go_fmt_command', 'gopls')
vim.api.nvim_set_var('go_gopls_gofumpt', 1)
vim.api.nvim_set_var('go_metalinter_command', 'golangci-lint')
vim.api.nvim_set_var('go_metalinter_command', 'golangci-lint')
vim.api.nvim_set_var('go_metalinter_enabled', {
  -- bugs: ALL
  'asasalint',
  'asciicheck',
  'bidichk',
  'contextcheck',
  'durationcheck',
  'errchkjson',
  'exhaustive',
  'exportloopref',
  'gosec',
  'makezero',
  'nilerr',
  'typecheck',
  -- comment: ALL
  'godot',
  'godox',
  'misspell',
  -- complexity: ALL
  'cyclop',
  'funlen',
  'gocognit',
  'gocyclo',
  'maintidx',
  'nestif',
  -- error: ALL
  'errcheck',
  'errorlint',
  'goerr113',
  'wrapcheck',
  -- format:
  'decorder',
  'gofumpt',
  -- metalinter: ALL
  'gocritic',
  'govet',
  'revive',
  'staticcheck',
  -- module: Good no need -- 'depguard', 'gomoddirectives', 'gomodguard'
  -- performance: ALL
  'bodyclose',
  -- 'maligned', REPLACED 'https://pkg.go.dev/golang.org/x/tools@v0.1.12/go/analysis/passes/fieldalignment/cmd/fieldalignment'
  'noctx',
  'prealloc',
  -- sql: ALL
  'execinquery',
  'rowserrcheck',
  'sqlclosecheck',
  -- style:
  'errname',
  -- TODO(jay): The rest of these
  'containedctx',
  -- 'dogsled', 'dupl', 'exhaustivestruct', 'exhaustruct', 'forbidigo', 'forcetypeassert', 'gochecknoglobals', 'gochecknoinits', 'goconst', 'goheader', 'golint', 'gomnd', 'goprintffuncname', 'gosimple', 'grouper', 'ifshort', 'importas', 'interfacer', 'ireturn', 'lll',  'nakedret', 'nilnil', 'nlreturn', 'nolintlint', 'nonamedreturns', 'nosnakecase', 'nosprintfhostport', 'predeclared', 'promlinter', 'stylecheck', 'tagliatelle', 'tenv', 'testpackage', 'thelper', 'unconvert', 'usestdlibvars', 'varnamelen', 'wastedassign', 'whitespace', 'wrapcheck', 'wsl'
  -- test:
  'paralleltest',
  'testpackage',
  'tparallel',
  -- unused: ALL
  'deadcode',
  'ineffassign',
  'structcheck',
  'unparam',
  'unused',
  'varcheck'
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
