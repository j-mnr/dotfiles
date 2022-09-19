local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = { buffer = 0 }
for _, lsp in pairs {
  'gopls',
 'sumneko_lua',
 'pylsp',
 'bashls',
 'clangd',
 'emmet_ls',
 'eslint',
 'tsserver',
 'tailwindcss',
 'cssls',
 } do
  local settings = {}
  if lsp == 'gopls' then
    settings = {
      gopls = {
        gofumpt = true,
      },
    }
  end

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
      vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
    end,
    settings = settings,
  }
end

-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
