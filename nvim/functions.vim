let g:AllPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', "`":"`"}

function! Skip_closing(pair)
  if s:get_character_at(1) == a:pair
    return "\<Right>"
  else
    return a:pair
  endif
endfunction

function! s:get_character_at(position)
  return strpart(getline('.'), col('.') - a:position, 1)
endfunction

function! Remove_pairs()
  let [before, after] = s:getline()
  for open in keys(g:AllPairs)
    let close = g:AllPairs[open]
    let b = matchstr(before, '\V' . open . '\v\s?$')
    let a = matchstr(after, '^\v\s*\V' . close)
    if b != '' && a != ''
      return "\<BS>\<DELETE>"
      " return s:backspace(b).s:delete(a)
    endif
  endfor
  return "\<BS>"
endfunction

function! s:getline()
  let line = getline('.')
  let pos = col('.') - 1
  let before = strpart(line, 0, pos)
  let after = strpart(line, pos)
  return [before, after]
endfunction

command! -range=% Camelcase call Lumpy(<count>)
command! -range=% Snakecase call Slithers(<count>)
command! -range=% GoJson call ToGoJson(<count>)

function! Lumpy(range) abort
  if a:range == -1
    execute "%s/\\l\\@<=_\\([a-z]\\)/\\u\\1/"
  else
    execute "'<,'>s/\\l\\@<=_\\([a-z]\\)/\\u\\1/"
  endif
endfunction

function! Slithers(range) abort
  if a:range == -1
    execute "%s/\\(\\l\\@<=[A-Z]\\)/_\\l\\1/"
  else
    execute "'<,'>s/\\(\\l\\@<=[A-Z]\\)/_\\l\\1/"
  endif
endfunction

function! ToGoJson(range) abort
  let json_property='"\(\w\+\)"'
  let go_json='`json:"\1"`'
  if a:range == -1
    execute "%s/" . json_property . ":/\\u\\1 " . go_json . "/"
  else
    execute "'<,'>s/".json_property.":/\\u\\1 string " . go_json . "/"
  endif
endfunction

function Eatchar(pattern)
  let char = nr2char(getchar(0))
  return (char =~ a:pattern) ? '' : char
endfunction

