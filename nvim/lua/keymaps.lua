vim.cmd 'let mapleader = " "'

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
-- TODO
nmap('<Leader>/', ':nohlsearch<CR>')
nmap('U', '<C-r>')
nmap('<Leader>v', '<C-v>')
-- All the LSP goodies
nmap('gd', ':lua vim.lsp.buf.definition()<CR>')
nmap('gD', ':lua vim.lsp.buf.declaration()<CR>')
nmap('gi', ':lua vim.lsp.buf.implementation()<CR>')
nmap('gw', ':lua vim.lsp.buf.document_symbol()<CR>')
nmap('gw', ':lua vim.lsp.buf.workspace_symbol()<CR>')
nmap('gr', ':lua vim.lsp.buf.references()<CR>')
nmap('gt', ':lua vim.lsp.buf.type_definition()<CR>')
nmap('K', ':lua vim.lsp.buf.hover()<CR>')
nmap('<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
nmap('<Leader>af', ':lua vim.lsp.buf.code_action()<CR>')
nmap('<Leader>rn', ':lua vim.lsp.buf.rename()<CR>')



local function vmap(key, map)
  keymap('v', key, map, opts)
end
vmap('J', ":m '>+1<CR>gv=gv")
vmap('K', ":m '<-2<CR>gv=gv")
