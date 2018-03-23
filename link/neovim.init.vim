" Set language to English
language en_US

" Hide buffers or whatever
set hidden

" Disable the arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Indentation
set expandtab
set shiftwidth=2
set softtabstop=2

" Remove spaces on join
set nojoinspaces

" Setup the line numbers
set relativenumber
set number

" Better move between splits
noremap <M-j> <C-W><C-J>
noremap <M-k> <C-W><C-K>
noremap <M-l> <C-W><C-L>
noremap <M-h> <C-W><C-H>
tnoremap <M-j> <C-\><C-n><C-w><C-j>
tnoremap <M-k> <C-\><C-n><C-w><C-k>
tnoremap <M-l> <C-\><C-n><C-w><C-l>
tnoremap <M-h> <C-\><C-n><C-w><C-h>
inoremap <M-j> <Esc><C-w><C-j>
inoremap <M-k> <Esc><C-w><C-k>
inoremap <M-l> <Esc><C-w><C-l>
inoremap <M-h> <Esc><C-w><C-h>

" Remap leader
" Don't set Space here, it'll slow down typing.
" Don't set semicolon here, it is overwritten by 'next f result' command
let mapleader = "\<Space>"

" Some buffer operations
nnoremap <leader>n :enew<cr>
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprevious<CR>

" Show some lines around coursor
set scrolloff=10

" Longer history
set history=1000

" Remove search highlight
nnoremap <C-c> :noh<CR>

" Paste from a yank buffer
nnoremap <leader>p "0p
nnoremap <leader>P "0P

" Paste from a system-wide clipboard
nnoremap <leader>8 "*p
nnoremap <leader>* "*P

" Case-insensitive search
set ignorecase
set smartcase

" More natural splits
set splitbelow
set splitright

" Add color line at certain width
set colorcolumn=80

" Write and close with leader
nnoremap <leader>w :w<CR>
nnoremap <leader>x :bp<CR>:bd#<CR>
nnoremap <leader>X :bp<CR>:bd!#<CR>

" Next/prev tab
noremap <M-n> gt
noremap <M-p> gT

" Exit terminal input mode
"tnoremap <C-q> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

" Quickly create a new terminal in a new tab
nnoremap <Leader>c :tab new<CR>:term<CR>

" Quickly create a new terminal in a vertical split
nnoremap <Leader>% :vsp<CR>:term<CR>

" Quickly create a new terminal in a horizontal split
nnoremap <Leader>" :sp<CR>:term<CR>

" Plugins
call plug#begin()
Plug 'iCyMind/NeoSolarized'     " Solarized theme
Plug 'airblade/vim-gitgutter'   " Vim gutter
Plug 'sheerun/vim-polyglot'     " Language packs for all languages
Plug 'bronson/vim-trailing-whitespace' " crystal-lang support
Plug 'scrooloose/nerdtree' " file drawer
Plug 'jiangmiao/auto-pairs' " pair brackets, quotes, etc
Plug '/usr/local/opt/fzf' " fzf fuzzy search
Plug 'junegunn/fzf.vim' " fzf fuzzy search
Plug 'vim-airline/vim-airline' " special kind of status bar
Plug 'vim-airline/vim-airline-themes' " themes for vim airline
Plug 'enricobacis/vim-airline-clock' " clock for vim airline
Plug 'tpope/vim-fugitive' " git assist
call plug#end()

" Setup solarized theme
syntax on
colorscheme NeoSolarized
set background=dark

" Always show the sign column of gitgutter
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Make vim pickup changes faster
set updatetime=100

" Setup auto-pairs
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutToggle = ''

" Toggle nerdtree shortcut
noremap <C-n> :NERDTreeToggle<CR>

" Shortcuts to fzf commands
noremap <C-b> :Buffers<CR>
noremap <C-a> :Ag<CR>
noremap <C-h> :History<CR>
noremap <C-f> :Files<CR>

" Setup fzf to ignore files in gitignore
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" Setup airline
" let g:airline#extensions#tabline#enabled = 1        " show tabline
" let g:airline#extensions#tabline#fnamemod = ':t'    " show only filename
let g:airline_theme='solarized'
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'z', 'error', 'warning' ]
      \ ]
let g:airline_section_b = airline#section#create(['branch'])
let g:airline_section_z = airline#section#create(['%1l',  ':%1v'])
