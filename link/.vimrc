" An example for a vimrc file.
"
" Maintainer:  Bram Moolenaar <Bram@vim.org>
" Last change:  2015 Mar 24
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"        for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"      for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file (restore to previous version)
  set undofile    " keep an undo file (undo changes after closing)
endif
set history=50    " keep 50 lines of command line history
set ruler    " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch    " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
endif " has("autocmd")

set autoindent    " always set autoindenting on

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Disable the arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let vundle manage vundle
Plugin 'gmarik/vundle'

" list all plugins that you'd like to install here
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plugin 'altercation/vim-colors-solarized' " solarized theme
Plugin 'kchmck/vim-coffee-script' " coffeescript support
Plugin 'mustache/vim-mustache-handlebars' " handlebars syntax plugin
Plugin 'scrooloose/nerdtree' " file drawer, open with :NERDTreeToggle
Plugin 'rhysd/vim-crystal' " crystal-lang support
Plugin 'bronson/vim-trailing-whitespace' " crystal-lang support
Plugin 'tpope/vim-surround' " surround with quotes and stuff
Plugin 'jiangmiao/auto-pairs' " pair brackets, quotes, etc
Plugin 'cakebaker/scss-syntax.vim' " sass syntax highlihgt
Plugin 'pangloss/vim-javascript' " js syntax
Plugin 'mxw/vim-jsx' " jsx for react syntax
Plugin 'mattn/emmet-vim' " emmet for faster html/css typing
" Plugin 'benmills/vimux'
" Plugin 'tpope/vim-fugitive' " the ultimate git helper
" Plugin 'tpope/vim-commentary' " comment/uncomment lines with gcc or gc in

call vundle#end()
filetype plugin indent on
syntax on
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Solarized settings
syntax enable
"Enable the switch of the background
"let hour = strftime("%H")
"if 10 <= hour && hour < 16
"  set background=light
"else
"  set background=dark
"endif
set background=dark
colorscheme solarized
call togglebg#map("<F5>")

" Setup the line numbers
set relativenumber
set number

" Change coursor when in insert mode
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' |
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
 endif

 " CTRLP open in a new tab on hitting enter
 let g:ctrlp_prompt_mappings = {
     \ 'AcceptSelection("e")': ['<c-t>'],
     \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
     \ }
" CTRLP index hidden files
let g:ctrlp_show_hidden = 1

" Search only in the working directory
let g:ctrlp_working_path_mode = 0

" Ignore some files for ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.?(git|hg|svn|node_modules|bower_components|.sass-cache)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Ignore files in tmp dirs and stuff
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Show search results while typing
set incsearch

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Show some lines around coursor
set scrolloff=10

" Reload the file if changed outside of vim
set autoread

" Longer history
set history=1000

" Fewer tabs
set tabpagemax=6

" Show tab line all the time
set showtabline=2

" Move backup and swap files to /tmp
set backupdir=./.backup,~/.backup,.,/tmp
set directory=./.backup,~/.backup,.,/tmp
set undodir=./.backup,~/.backup,.,/tmp

" Disable safe write to allow dev servers to pick changes
set backupcopy=yes

" Something with tabs
set smarttab

" System-wide clipboard
"set clipboard=unnamed
set clipboard+=unnamed

" Case-insensitive search
set ignorecase
set smartcase

" Auto change current directory to current file's
"set autochdir

set splitbelow
set splitright

" Auto close the brackets
inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i
inoremap { {}<Esc>:let leavechar="}"<CR>i
imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a

" Paste from 0 buffer without typing "
let mapleader = "\<Space>"
noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p

" Add file path to status line
set statusline+=%f
set laststatus=2

" Add function to see diff between edited and saved version of the file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Allow JSX in normal JS files
let g:jsx_ext_required = 0

" Show as much of the last line as possible
set display +=lastline

" Show non-printables
set list
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" Redefine emmet leader
let g:user_emmet_leader_key=','

" Set spell checking for markdown
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.markdown setlocal spell

hi SpellBad cterm=underline ctermfg=lightred ctermbg=black
hi SpellCap cterm=underline ctermfg=lightred ctermbg=black
hi SpellRare cterm=underline ctermfg=lightred ctermbg=black
hi SpellLocal cterm=underline ctermfg=lightred ctermbg=black

" Change cursor in insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Add color line at certain width
set colorcolumn=68
