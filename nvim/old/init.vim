" Bare Necessities
set nocompatible
syntax enable
filetype plugin on
filetype indent on

" File Explorer netrw |netrw-browse-maps|
let g:netrw_banner=0 " disable banner
let g:netrw_winsize=20 " don't take up entire screen
let g:netrw_liststyle=3 " tree view best view
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1 " open splits to the right
let g:netrw_list_hide=netrw_gitignore#Hide() " |netrw-gitignore|
" hides dotfiles flet g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'
" By default netrw leaves unmoded buffs open. This deletes them.
autocmd FileType netrw setl bufhidden=delete " or use :qa!

autocmd FileType go set noexpandtab " Go I love you but..... >:(

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . site_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let data_dir = has('nvim') ? stdpath('data') : '~/.vim'
call plug#begin(data_dir . "/plugged")
Plug 'tpope/vim-surround'
Plug 'ray-x/aurora'
Plug 'nvim-treesitter/nvim-treesitter',
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'frazrepo/vim-rainbow'
call plug#end()

let g:rainbow_active = 1
"set termguicolors
"colorscheme aurora

"set virtualedit=all " Virtual edit best edit
" autocommand to save on losing focus
:au FocusLost,WinEnter,WinLeave * silent! update
":au BufWrite,BufEnter,InsertLeave * lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
"set gdefault " turns on [g] flag for :substitute
"set autowriteall " It does as it says
"set autoread " automatically reload files upon change outside editor
"set list " shows the invisible characters
"set listchars=space:·,tab:>\ ,trail:-,extends:>,precedes:<
"set numberwidth=1 " spacing from the line number
"set splitright " new windows appear to the right
"set splitbelow " new windows apper at bottom
"set showcmd " BEST!!! shows what you type for cmd
set scrolloff=999 " Center vertically
set sidescroll=1 " No jarring jump when nowrap is set
set sidescrolloff=999 " Center horizontally
"set cursorline " puts a line under where you are
"set lazyredraw " smoother faster macros
"set number " yay for line numbers!
"set ruler " gives you the bar at the bottom
"set signcolumn=yes " the signcolumn can also have line =number!
"set laststatus=2 " sets the statusline to show
"set noswapfile " I wonder what it does....
"set undofile " allows for undoing after saving and before session removed
"set undodir=/tmp " without this undofile would not make a file
"set updatetime=100 " makes the swap file update
" For programming
"set showmatch " show matching bracket
"set foldenable " allows folding of code blocks
"set foldnestmax=4 " max folds allowed in a nest
set foldlevel=1 " folds blocks inside functions
set foldlevelstart=2 " fold level when going to new window 2 for popup
"set foldmethod=indent " Python exclusive
"set colorcolumn=80 " puts the border column
"set textwidth=79 " ??? When pasting won't let it past colorcolumn...maybe
" Tabs and spacing
"set tabstop=2 " Who the hell like this at 8?
"set softtabstop=2 " actual num spaces of tab
"set shiftwidth=2 " > and < spaces
"set expandtab
"set smarttab " insert blanks when hitting tab in front of a line
"set smartindent " it's not dumb
"set autoindent " what's in a name?
"set cindent " XXX: This screws `.md` all the indents
"set backspace=indent,eol,start "XXX: default auto backspace depending on prev char
"set nostartofline " XXX: default won't push you back to start of line when moving rows
" Searching
"set incsearch " incomplete search shows
"set ignorecase
"set smartcase " toggles ignorecase depending on your search
" use :find to act as fzf
"set path+=** " Search all subdirs and -r
set wildmenu " :TAB to pull up wildmenu
set wildmode=list:longest,full " gives you what you want
set wildignore=**/node_modules/** " fuck you node modules


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

source $XDG_CONFIG_HOME/nvim/coc.vim
source $XDG_CONFIG_HOME/nvim/mappings.vim
source $XDG_CONFIG_HOME/nvim/old/jayline.vim
source $XDG_CONFIG_HOME/nvim/functions.vim

