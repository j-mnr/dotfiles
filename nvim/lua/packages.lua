require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  -- nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  -- snippets for nvim-cmp
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'nvim-treesitter/nvim-treesitter'
  use 'tanvirtin/monokai.nvim'
  use 'kyazdani42/nvim-web-devicons'
end)
