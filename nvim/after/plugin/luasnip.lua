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
  go = {
    snip('fln', 'fmt.Println($0)'),
    snip('ff', 'fmt.Printf("%v\\n", $0)'),
    -- TODO(jay): Expand this out to return option as well
    snip('lf', 'log.Fatal(err)'),
    snip('er', 'if err != nil {\n\tlog.Fatal(err)\n}\n$0'),
    snip('main', 'package main\n\nfunc main() {\n\t$0\n}'),
    snip('ex', 'func Example$0() {\n\t// Output:\n}\n'),
    snip('wrap', 'fmt.Errorf("$0: %w", err)'),
    snip('todo', '// TODO(jay): $0'),
    snip('anon', 'func() {\n\t$0\n}()'),
    snip('pprof', 'pprofFile, pprofErr := os.Create("cpu.pprof")\nif pprofErr != nil {\n\tlog.Fatal(pprofErr)\n}\npprof.StartCPUProfile(pprofFile)\ndefer pprof.StopCPUProfile()')
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
