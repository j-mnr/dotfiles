local ls = require 'luasnip'
local rep = require 'luasnip.extras'.rep
local fmt = require 'luasnip.extras.fmt'.fmt
local types = require 'luasnip.util.types'
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

ls.config.set_config {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = false,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<-', 'Error' } },
      }
    }
  }
}

vim.keymap.set({ 'i', 's' }, '<C-k>', function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-j>', function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
vim.keymap.set('i', '<C-l>', function ()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
vim.keymap.set('n', '<Leader><Leader>s', '<Cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')

local snip = ls.parser.parse_snippet
ls.snippets = {
  all = {
    snip('expand', '-- this is what was expanded'),
            s(
            "fmt1",
            fmt("To {title} {} {}.", {
                i(2, "Name"),
                i(3, "Surname"),
                title = c(1, { t("Mr."), t("Ms.") }),
            })
        ),

  },
  go = {
    s('fp', fmt('fmt.Print{type}({})', {
      i(2),
      type = c(1, { t 'ln', t 'f', t '', }),
    })),
    s('func', fmt('// {}{}\nfunc {}({}) {} {{\n\treturn {}\n}}', {
      i(1), i(2), rep(1), i(3), i(4), i(0),
    })),
    snip('er', 'if err != nil {\n\treturn $0\n}'),
  },
  lua = {
    snip('lf', '--Defined in $TM_FILENAME\nlocal $1 = function($2)\n $0\nend'),
    snip('mf', '$1.$2 = function($3)\n $0\nend'),
    s('req', fmt("local {} = require '{}'", { i(1, 'default'), rep(1) })),
  },
}
