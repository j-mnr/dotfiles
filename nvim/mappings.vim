let mapleader = " "
" -- GOD TIER --
inoremap jj <Esc>l
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" == AUTO-COMPLETE ==
" Parens
inoremap ( ()<Left>
inoremap <silent>) <C-r>=Skip_closing(')')<CR>
" Brackets
inoremap [ []<Left>
inoremap <silent>] <C-r>=Skip_closing(']')<CR>
" Squirrely Braces
inoremap { {}<Left>
inoremap <silent>} <C-r>=Skip_closing('}')<CR>
" -- INSERT --
inoremap \\ <C-o>
" -- NORMAL --
nnoremap j gj
nnoremap k gk
nnoremap <Leader>nl o<Esc>
nnoremap <Leader>nL O<Esc>
nnoremap <Leader>ra :%s/\<\(<C-r><C-w>\)\>/
nnoremap U <C-r>
nnoremap <Leader>v <C-v>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>e :Lex<CR>
nnoremap <Leader>[ :cnext<CR>
nnoremap <Leader>] :cprev<CR>
nnoremap <Leader>/ :noh<CR>
nnoremap <Leader><CR> :7sp<CR>:term<CR>i
" -- VISUAL --
vnoremap <Leader>v "_dP
vnoremap // y/\V<C-r>=escape(@", '/\')<CR><CR>
vnoremap ra y:%s/\(<C-r>=escape(@", '/\')<CR>\)/
" Sorting
vnoremap <Leader>s :'<,'>!sort -f<CR>
" Remove trailing whitespaces
nnoremap <silent> <Leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s
                             \ <Bar> :nohl <Bar> :unlet _s <CR>
" -- TERMINAL --
tnoremap \<CR> <C-\><C-n>
tnoremap \2 <C-\><C-n>:res2<CR>:wincmd k<CR>
tnoremap \c <C-c>
" -- GLOBAL --
"  Yank & Pull
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
nnoremap <Leader>Y gg"+yG
" Make what you will
nnoremap <Leader>m :let &makeprg=""<Left>
nnoremap <Leader>c :cclose<CR>:silent !clear<CR>:make<CR>
" -- WINDOWS --
" or <C-W> o
nnoremap <Leader>ww :only<CR>
nnoremap <Leader>gs <C-^>
nnoremap <Leader>o <C-O>
nnoremap <Leader>i <C-I>
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>
nnoremap <Leader>\ :vsp<CR>
" -- PLUGINS --
" FZF
nnoremap <Leader>p :Files<CR>
" Prettier
nnoremap <Leader>gq :Format<CR>:silent OR<CR>

" -- ALIASES --
iabbrev pln fmt.Println("")<Left><Left><C-r>=Eatchar('\s')<CR>
iabbrev pf fmt.Printf("")<Left><Left><C-r>=Eatchar('\s')<CR>
