set nocompatible " Don't try to be Vi compatible
filetype plugin on
filetype indent on

call plug#begin("~/.local/share/nvim/plugged")
Plug 'tpope/vim-surround'
Plug 'folke/tokyonight.nvim'
Plug 'tanvirtin/monokai.nvim'
Plug 'nvim-treesitter/nvim-treesitter',
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'sheerun/vim-polyglot'
Plug 'frazrepo/vim-rainbow'
call plug#end()

let g:rainbow_active = 1
set termguicolors
let g:tokyonight_style = "night"
colorscheme monokai

set virtualedit=all " Virtual edit best edit
" autocommand to save on losing focus
:au FocusLost,WinEnter,WinLeave * silent! update
":au BufWrite,BufEnter,InsertLeave * lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
set gdefault " turns on [g] flag for :substitute
set autowriteall " It does as it says
set autoread " automatically reload files upon change outside editor
set list " shows the invisible characters
set listchars=space:·,tab:>\ ,trail:-,extends:>,precedes:<
set numberwidth=1 " spacing from the line number
set splitright " new windows appear to the right
set splitbelow " new windows apper at bottom
set showcmd " BEST!!! shows what you type for cmd
set scrolloff=999 " Center vertically
set sidescroll=1 " No jarring jump when nowrap is set
set sidescrolloff=999 " Center horizontally
set cursorline " puts a line under where you are
set wildmenu " :TAB to pull up wildmenu
set wildmode=list:longest,full " gives you what you want
set wildignore=**/node_modules/** " fuck you node modules
set lazyredraw " smoother faster macros
set number " yay for line numbers!
set ruler " gives you the bar at the bottom
set signcolumn=yes " the signcolumn can also have line =number!
set laststatus=2 " sets the statusline to show
set noswapfile " I wonder what it does....
set undofile " allows for undoing after saving and before session removed
set undodir=/tmp " without this undofile would not make a file
set updatetime=100 " makes the swap file update
" For programming
set showmatch " show matching bracket
set foldenable " allows folding of code blocks
set foldnestmax=4 " max folds allowed in a nest
set foldlevel=1 " folds blocks inside functions
set foldlevelstart=2 " fold level when going to new window 2 for popup
set foldmethod=indent " Python exclusive
set colorcolumn=80 " puts the border column
set textwidth=79 " ??? When pasting won't let it past colorcolumn...maybe
" Tabs and spacing
set tabstop=2 " num spaces tab displays
set softtabstop=2 " actual num spaces of tab
set shiftwidth=2 " > and < spaces
set expandtab " convert tab to spaces
set smarttab " insert blanks when hitting tab in front of a line
set smartindent " it's not dumb
set autoindent " what's in a name?
set cindent " all the indents
set backspace=indent,eol,start " auto backspace depending on prev char
set nostartofline " won't push you back to start of line when moving rows
" Searching
set incsearch " incomplete search shows
set smartcase " toggles ignorecase depending on your search
set path+=** " Search all subdirs and -r
" File Explorer netrw
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=20
" By default netrw leaves unmoded buffs open. This deletes them.
autocmd FileType netrw setl bufhidden=delete " or use :qa!

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

source $XDG_CONFIG_HOME/nvim/coc.vim
source $XDG_CONFIG_HOME/nvim/mappings.vim
source $XDG_CONFIG_HOME/nvim/jayline.vim
source $XDG_CONFIG_HOME/nvim/functions.vim

