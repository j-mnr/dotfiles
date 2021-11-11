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
set statusline+=%#LspReferenceText# |"BG Grey
set statusline+=%{g:currentmode[mode()]}
set statusline+=%#Statement# |"Purple
set statusline+=%{gitbranch}
set statusline+=%#Bold#\|\|
set statusline+=%#markdownH2# |"Blue
set statusline+=%<
set statusline+=%(\ %f%)
set statusline+=%m
set statusline+=%=
set statusline+=\ [%{strftime('%H:%M')}]
set statusline+=%#Bold#\|\|
set statusline+=%#Character# |"Green
set statusline+=%{&fileformat}
set statusline+=\|%{strlen(&fenc)?&fenc:'none'}
set statusline+=%#Bold#\|\|
set statusline+=%#diffOldFile# |"Yellow
set statusline+=%{strlen(&ft)?&ft:'none'}
set statusline+=%#Bold#\|\|
set statusline+=%#Constant# |"Orange
set statusline+=%l/%L\ %c
set statusline+=%#Bold#\|\|
set statusline+=%#BufferVisibleTarget# |"Red
set statusline+=%p%%
set statusline+=\ %r
