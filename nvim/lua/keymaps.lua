vim.g.mapleader = ' '

local keymap = vim.keymap.set

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
-- Quick/Loc List aka PROJECT WIDE
nmap('[c', '<Cmd>cprev<CR>zz')
nmap(']c', '<Cmd>cnext<CR>zz')
nmap('<Leader><Leader>cw', '<Cmd>cw<CR>')
nmap('<Leader><Leader>cf', '<Cmd>:Cfilter! <C-r><C-f><CR>')
-- TODO(jay.monari): Add :cdo s/foo/bar/ | update && :cfdo bd
nmap('[l', '<Cmd>lprev<CR>')
nmap(']l', '<Cmd>lnext<CR>')
nmap('<Leader><Leader>lw', '<Cmd>lw<CR>')
-- Term
nmap('<Leader>\\', '<Cmd>vsplit<CR>')
nmap('<Leader><CR>', '<Cmd>7sp<CR><Cmd>term<CR>i')
-- Should be Stock Mappings
nmap('U', '<C-r>')
nmap('<Leader>v', '<C-v>')
nmap('<Leader>+', '"+P')
-- vim-go
nmap('<Leader><Leader>d', '<Cmd>GoDebug<CR>')
nmap('<Leader><Leader>ta', '<Cmd>GoTest<CR>')
nmap('<Leader><Leader>tf', '<Cmd>GoTestFunc<CR>')
-- TODO
nmap('<Leader>/', '<Cmd>nohlsearch<CR>')
nmap('<Leader>ra', ':%s/\\<\\(<C-r><C-w>\\)\\>/')

local function vmap(key, map)
  keymap('v', key, map, opts)
end
vmap('J', ":m '>+1<CR>gv=gv")
vmap('K', ":m '<-2<CR>gv=gv")
vmap('<Leader>y', '"+y')
vmap('/', '"yy/<C-r>y<CR>')

-- Defined in keymaps.lua
local function tmap(key, map)
  keymap('t', key, map, opts)
end
tmap('\\\\', '<C-\\><C-n>')
tmap('\\h', '<C-\\><C-n><C-w>h')
tmap('\\j', '<C-\\><C-n><C-w>j')
tmap('\\k', '<C-\\><C-N><C-w>k')
tmap('\\l', '<C-\\><C-n><C-w>l')
