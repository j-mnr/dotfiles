vim.opt_local.suffixesadd:prepend('.lua')
vim.opt_local.suffixesadd:prepend('init.lua')
vim.opt_local.path:prepend(vim.fn.stdpath('config')..'/lua')
vim.opt_local.path:append('/home/jay/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server')
