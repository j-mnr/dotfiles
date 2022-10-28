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
  performance = {
    debounce = 350,
  }
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
