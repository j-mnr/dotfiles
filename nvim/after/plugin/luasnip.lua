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

ls.add_snippets(nil, {
  all = {
    ls.parser.parse_snippet('expand', '-- this is what was expanded!'),
  },
  go = {
    ls.parser.parse_snippet('fln', 'fmt.Println($0)'),
    ls.parser.parse_snippet('ff', 'fmt.Printf($0)'),
    -- TODO(jay): Expand this out to return option as well
    ls.parser.parse_snippet('lf', 'log.Fatal(err)'),
    ls.parser.parse_snippet('er', 'if err != nil {\n\tlog.Fatal(err)\n}\n$0'),
    ls.parser.parse_snippet('pkgmain', 'package main\n\nfunc main() {\n\t$0\n}'),
    -- Require snippets
    ls.parser.parse_snippet('rnerr', 'require.NoError(t, err)'),
    ls.parser.parse_snippet('rnem', 'require.NotEmpty(t, $0)'),
    ls.parser.parse_snippet('rnz', 'require.NotZero(t, $0)'),
    ls.parser.parse_snippet('re', 'require.Equal(t, $0)'),
    ls.parser.parse_snippet('rwd', 'require.WithinDuration(t, $1, $2, $3)'),
  },
  java = {
    ls.parser.parse_snippet('psvm', 'public static void main(String[] args) {\n  $0\n}'),
    ls.parser.parse_snippet('sout', 'System.out.println($0);'),
  }
})

vim.keymap.set('n', '<Leader><Leader>s',
  '<Cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')

vim.keymap.set('i', '<C-k>', function()
  if ls.expand_or_jumpable() then ls.expand_or_jump() end
end)
