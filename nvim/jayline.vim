" :so /usr/share/nvim/runtime/syntax/hitest.vim
let g:currentmode = {
  \ 'n' : '    ',
  \ 'v' : '    ',
  \ 'V' : '    ',
  \ "\<C-v>" : '    ',
  \ 'i' : '    ',
  \ 'R' : '    ',
  \ 'Rv' : '    ',
  \ 'c' : '    ',
  \ 's' : '    ',
  \ 't' : '    '
  \ }

function! StatuslineGitBranch()
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        return "   ".substitute(l:gitrevparse, '\n', '', 'g')
      endif
    catch
      return ""
    endtry
  endif
  return ""
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END
let gitbranch = StatuslineGitBranch()

set statusline=
set statusline+=%#FloatShadow# |"BlackBGWhiteFG
set statusline+=%{g:currentmode[mode()]}
set statusline+=%#Character# |"Purple
set statusline+=%{gitbranch}
set statusline+=%#Conditional#\|\|
set statusline+=%#markdownEscape# |"Blue
set statusline+=%<
set statusline+=%(\ %f%)
set statusline+=%m
set statusline+=%=
set statusline+=\ [%{strftime('%H:%M')}]
set statusline+=%#Conditional#\|\|
set statusline+=%#Constant# |"Green
set statusline+=%{&fileformat}
set statusline+=\|%{strlen(&fenc)?&fenc:'none'}
set statusline+=%#Conditional#\|\|
set statusline+=%#sqlKeyword# |"Yellow
set statusline+=%{strlen(&ft)?&ft:'none'}
set statusline+=%#Conditional#\|\|
set statusline+=%#Number# |"Orange
set statusline+=%l/%L\ %c
set statusline+=%#Conditional#\|\|
set statusline+=%#Float# |"Red
set statusline+=%p%%
set statusline+=\ %r
