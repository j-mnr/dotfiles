local fn = vim.fn
local api = vim.api

local modes = {
  ['n']  = '😃',
  ['no'] = 'N·P',
  ['v']  = '👁️',
  ['V']  = '🚃',
  [''] = '🚧',
  ['s']  = 'S',
  ['S']  = 'S·L',
  [''] = 'S·B',
  ['i']  = '🦋',
  ['ic'] = '🦋',
  ['R']  = '😎',
  ['Rv'] = '🦮',
  ['c']  = '💽',
  ['cv'] = '💽',
  ['ce'] = '💽',
  ['r']  = 'P',
  ['rm'] = 'M',
  ['r?'] = 'C',
  ['!']  = '🐚',
  ['t']  = '💻',
}

local function mode()
  local current_mode = api.nvim_get_mode().mode
  return string.format(' %s ', modes[current_mode]):upper()
end

local function filepath()
  local fpath = fn.fnamemodify(fn.expand '%', ':~:.:h')
  if fpath == '' or fpath == '.' then
      return ' '
  end

  return string.format(' %%<%s/', fpath)
end

local function filename()
  local fname = fn.expand '%:t'
  if fname == '' then
      return ''
  end
  return fname .. ' '
end

local function lsp()
  local count = {}
  local levels = {
    errors = 'Error',
    warnings = 'Warn',
    info = 'Info',
    hints = 'Hint',
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ''
  local warnings = ''
  local info = ''
  local hints = ''
  if count['errors'] ~= 0 then
    errors = ' %#LspDiagnosticsSignError# ' .. count['errors']
  end
  if count['warnings'] ~= 0 then
    warnings = ' %#LspDiagnosticsSignWarning# ' .. count['warnings']
  end
  if count['hints'] ~= 0 then
    hints = ' %#LspDiagnosticsSignHint# ' .. count['hints']
  end
  if count['info'] ~= 0 then
    info = ' %#LspDiagnosticsSignInformation# ' .. count['info']
  end

  return errors .. warnings .. hints .. info .. '%#Normal#'
end

local function filetype()
  local file_name, file_ext = fn.expand '%:t', fn.expand '%:e'
  local icon = require('nvim-web-devicons').get_icon(
    file_name,
    file_ext,
  { default = true })

  local ft = vim.bo.filetype

  if ft == '' then
    return ' No FT '
  end

  return string.format(' %s %s', icon, ft):lower()
end

local function lineinfo()
  if vim.bo.filetype == 'alpha' then
    return ''
  end
  return ' %l:%c %P'
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat {
     " ",
     added,
     changed,
     removed,
     " ",
     "%#GitSignsAdd# ",
     git_info.head,
     " %#Normal#",
  }
end

local colors = {
  purple = '%#TSConstMacro#',
  blue = '%#TSConstant#',
  green = '%#TSAnnotation#',
  yellow = '%#TSCharacter#',
  orange = '%#TSVariableBuiltin#',
  red = '%#TSInclude#',
  gray = '%#TSComment#',
  white = '%#TSVariable#',
}

Statusline = {}

Statusline.active = function ()
  return table.concat {
    '%#Statusline#',
    mode(),
    colors.purple,
    vcs(),
    colors.blue,
    filepath(),
    filename(),
    lsp(),
    '%=',
    colors.green,
    vim.bo.fileformat .. ' ',
    colors.orange,
    vim.bo.fileencoding,
    colors.yellow,
    filetype(),
    colors.red,
    lineinfo(),
  }
end

function Statusline.inactive()
  return '%= ' .. colors.gray .. '%F' .. '%#Statusline#' .. '%='
end

function Statusline.short()
  return '%#StatusLineNC#   NvimTree'
end

vim.cmd [[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]]
