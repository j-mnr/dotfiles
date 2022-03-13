vim.cmd [[ let mapleader = ' ' ]]

local api = vim.api
local keymap = api.nvim_set_keymap

local opts = { noremap = true }

vim.cmd [[
function! s:get_character_at(position)
  return strpart(getline('.'), col('.') - a:position, 1)
endfunction

 function! Skip_closing(pair)
  if s:get_character_at(1) == a:pair
    return "\<Right>"
  else
    return a:pair
  endif
endfunction

inoremap <silent>] <C-r>=Skip_closing(']')<CR>
inoremap <silent>) <C-r>=Skip_closing(')')<CR>
inoremap <silent>} <C-r>=Skip_closing('}')<CR>
]]

local function imap(key, map)
  keymap('i', key, map, opts)
end
imap('jj', '<Esc>')
imap('(', '()<Left>')
imap('[', '[]<Left>')
imap('{', '{}<Left>')
imap('(<CR>', '(<CR>)<C-o>O')
imap('[<CR>', '[<CR>]<C-o>O')
imap('{<CR>', '{<CR>}<C-o>O')

local function nmap(key, map)
  keymap('n', key, map, opts)
end
-- Move to window
nmap('<Leader>k', '<C-w><C-k>')
nmap('<Leader>j', '<C-w><C-j>')
nmap('<Leader>h', '<C-w><C-h>')
nmap('<Leader>l', '<C-w><C-l>')
-- Jumplist
nmap('<Leader>o', '<C-o>')
nmap('<Leader>i', '<C-i>')
-- Taglist
nmap('<Leader>t', '<C-t>')
-- Make
nmap('<Leader>m', ':let &makeprg=""<Left>')
nmap('<Leader>c', ':cclose<CR>:silent !clear<CR>:make<CR>')
-- TODO
nmap('<Leader>/', '<Cmd>nohlsearch<CR>')
nmap('U', '<C-r>')
nmap('<Leader>v', '<C-v>')
nmap('<Leader>\\', '<Cmd>vsplit<CR>')
nmap('<Leader><CR>', '<Cmd>7sp<CR>:term<CR>i')

local function vmap(key, map)
  keymap('v', key, map, opts)
end
vmap('J', ":m '>+1<CR>gv=gv")
vmap('K', ":m '<-2<CR>gv=gv")
