require 'keymaps'
require 'packages'
require 'config'
require 'statusline'

require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  highlight = { enable = true },
}

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args) require 'luasnip'.lsp_expand(args.body) end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['|'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-q>'] = cmp.mapping.confirm { select = false }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<S-Tab>'] = function(fallback)
      return cmp.visible() and cmp.select_prev_item() or fallback()
    end,
    ['<Tab>'] = function(fallback)
      return cmp.visible() and cmp.select_next_item() or fallback()
    end
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'emoji' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = { buffer = 0 }
for _, lsp in pairs { 'gopls', 'sumneko_lua', 'pylsp', 'bashls', 'clangd', 'tsserver', 'emmet_ls', 'eslint', 'tsserver', 'tailwindcss' } do
  local settings = {}
  if lsp == 'sumneko_lua' then
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'use' },
        },
      }
    }
  end
  require 'lspconfig'[lsp].setup {
    capabilities = capabilities,
    on_attach = function()
      vim.keymap.set('n', '<Leader><Leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gq', function() vim.lsp.buf.format { async = true }
      end, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, opts)
    end,
    settings = settings,
  }
end

-- TODO(jaymonari): map these things... One a day?
--  local opts = { noremap=true, silent=true }
--  vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
