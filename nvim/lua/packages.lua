require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  use 'ray-x/aurora'
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
        local startify = require'alpha.themes.startify'
        require'alpha'.setup(startify.opts)
        startify.section.bottom_buttons.val = {
          startify.button('c', 'neovim config', ':e ~/.config/nvim/init.lua<CR>')
        }
        vim.api.nvim_set_keymap('n', '<C-n>', ':Alpha<CR>', { noremap = true })
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require'nvim-treesitter.configs'.setup = {
        ensure_installed = 'maintained',
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        }
      }
    end
  }
  use 'neovim/nvim-lspconfig'
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require("nvim-lsp-installer").on_server_ready(function(server)
        local opts = {}
        if server.name == "sumneko_lua" then
          opts = {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim', 'use' }
                },
              }
            }
          }
        end
        server:setup(opts)
      end)
    end
  }
  use'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
end)
