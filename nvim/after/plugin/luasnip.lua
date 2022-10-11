local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
  history = false,
  updateevents = 'InsertLeave',
  delete_check_events = 'InsertLeave',
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<-', 'Error' } },
      },
    },
  },
}

local snip = ls.parser.parse_snippet
ls.add_snippets(nil, {
  all = {
    snip('expand', '-- this is what was expanded!'),
  },
  go = {
    snip('fln', 'fmt.Println($0)'),
    snip('ff', 'fmt.Printf($0)'),
    -- TODO(jay): Expand this out to return option as well
    snip('lf', 'log.Fatal(err)'),
    snip('er', 'if err != nil {\n\tlog.Fatal(err)\n}\n$0'),
    snip('main', 'package main\n\nfunc main() {\n\t$0\n}'),
    snip('ex', 'func Example$0() {\n\t// Output:\n\t//\n}'),
    snip('wrap', 'fmt.Errorf("$0: %w", err)'),
  },
  java = {
    snip('psvm', 'public static void main(String[] args) {\n  $0\n}'),
    snip('sout', 'System.out.println($0);'),
  }
})

vim.keymap.set('n', '<Leader><Leader>s',
  '<Cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')

vim.keymap.set('i', '<C-k>', function()
  if ls.expand_or_jumpable() then ls.expand_or_jump() end
end)
