local o = vim.opt
o.expandtab = true
o.shiftwidth = 2
o.softtabstop = 2

o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'

o.number = true

o.termguicolors = true
vim.cmd 'colorscheme aurora'
