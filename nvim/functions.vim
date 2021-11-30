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

function CamelCase() range abort
  execute a:firstline . ',' . a:lastline . 's/\l\@<=_\([a-z]\)/\u\1/'
endfunction

function SnakeCase() range abort
  execute a:firstline . ',' . a:lastline . 's/\(\l\w\+\)\@<=\(\u\)/_\l\2'
endfunction

function ToGoJson() range abort
  let json_property='"\(\w\+\)"'
  let go_json='`json:"\1"`'
  echo a:firstline . ',' . a:lastline
  execute a:firstline . ',' . a:lastline . 's/' . l:json_property . ':/\u\1 string ' . l:go_json . '/'
endfunction

function JsonToGo()
endfunction

function Eatchar(pattern)
  let char = nr2char(getchar(0))
  return (char =~ a:pattern) ? '' : char
endfunction

function ToggleComment() range abort
  " TODO implement this for all file types
  let ft=&filetype
  let cmt = '\/\/'
  if ft == "python" || ft == "sh"
    let cmt = '#'
  endif

  if getline(".") =~ '^\%(\s*\)' . cmt
    execute ":" . a:firstline . "," . a:lastline . 's/^\(\s*\)' . l:cmt . ' \(.*\)$/\1\2/'
  else
    call search('\w')
    let ch = getline(".")[col(".")-2]
    let [_, _, c, _] = getpos('.')
    if l:c == 2 && l:ch !=# "	"
      let c = 1
    endif
    execute ":" . a:firstline . "," . a:lastline . 's/^\(.*\%' . l:c . 'c\)\(.*\)$/\1' . l:cmt . ' \2/'
  endif
endfunction

vmap <Leader>cc :call CamelCase()<CR>
vmap <Leader>sc :call SnakeCase()<CR>
vmap <Leader>gj :call ToGoJson()<CR>
vmap <Leader><Leader> :call ToggleComment()<CR>
