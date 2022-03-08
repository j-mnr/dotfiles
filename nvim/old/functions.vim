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

function GoToJson() range abort
  " TODO Make this work for values larger than two aka `ThreeTimesField int`
  let currline = a:firstline
  while currline <= a:lastline
    if getline(currline) =~# '\v(.*(<\u+>).*)'
      execute currline . 's/\v(.*(<\u+>).*)/\1 `json:"\L\2"`/e'
    else
      execute currline . 's/\v(.*(<\u\w+).*)/\1 `json:"\l\2"`/e'
    endif
    execute currline . 's/\v(`json:"\l+)(\u+)(.*)/\1_\L\2\3/e'
    let currline += 1
  endwhile
endfunction

" TODO omitempty
function JsonToGo() range abort
  let json_property='"\(\w\+\)"'
  let go_json='`json:"\1"`'
  let lineN = a:firstline
  while lineN <= a:lastline
    let curr_line = getline(lineN)
    if curr_line =~# '",\?$'
      try
        execute lineN . 's/' . json_property . ':.*/\u\1 string ' . go_json . '/'
      catch
      endtry
    elseif curr_line =~# '[$'
      " TODO integrate this '\[\_.\{-}\],\?'
      " TODO eats up too many lines, need to go forward until find ]
      execute lineN . 's/' . json_property . ':.*\[\_.\{-}\],\?/\u\1 []struct ' . go_json . '/'
      echo 'array'
    elseif curr_line =~# '\(true\|false\)$'
      echo 'boolean'
    elseif curr_line =~# '\d$'
      echo 'number'
    endif
    let lineN += 1
  endwhile
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

vmap <Leader>jg :call JsonToGo()<CR>
vmap <Leader>cc :call CamelCase()<CR>
vmap <Leader>sc :call SnakeCase()<CR>
vmap <Leader>gj :call GoToJson()<CR>
vmap <Leader><Leader> :call ToggleComment()<CR>
