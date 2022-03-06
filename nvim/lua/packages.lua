require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
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
  use 'nvim-treesitter/nvim-treesitter'
  use 'tanvirtin/monokai.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
end)
