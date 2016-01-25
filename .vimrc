"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    ===== MY.VIMRC =====
"
" Maintainer:
"      Bui-Khanh Hoang
"
" Reference:
"      https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
"      http://vim.wikia.com/wiki
"      googling && stackoverflow
"
" Sections:
"    - General
"    - VIM user interface
"    - Custom utilities
"    - Plugin management with vundle
"    - Plugin configurations
"       + nerdtree
"       + vim-session
"
" Convention note:
"    - Make sure url links stand clear from other irrelavant texts so that
"      those links can be brought up in a browser from the current termnial
"      with \w command utility [ specified in custom utilities section ].
"      And 80-character line length rule will not be used for url links
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Faster jumping to normal mode - using jk combination in place of ESC key
imap jk <Esc>

" Set leader key as <space>
let mapleader="\<Space>"

" Ignore case when searching
set ignorecase

" Turn case-sensitive search on whenever a capital letter appears in keyword
set smartcase

" Highlight search results
set hlsearch

" Toggle search highligting
nnoremap <F4> :set hlsearch!<CR>

" Disable highlight when <leader><cr> is pressed
" NOTE: <cr> == <enter>
map <silent> <leader><cr> :noh<cr>

" Showing the matches while typing the pattern
set incsearch

" Showing matching brackets
set showmatch

" Add a bit extra margin to the left
set foldcolumn=0

" Allow mouse to function in vim
set mouse=a

" Make ctrl-v and ctrl-p behave normally as in a typical editor
behave mswin
set clipboard=unnamedplus
smap <Del> <C-g>"_d
smap <C-c> <C-g>y
smap <C-x> <C-g>x
imap <C-v> <Esc>pi
smap <C-v> <C-g>p
smap <Tab> <C-g>1>
smap <S-Tab> <C-g>1<

" Turning off list
set nolist

" Turning on list with customized special charactedr
" set list listchars=tab:»·,eol:¬

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set dark background for all colorscheme
set background=dark

" Making terminal vim have the same colorscheme as in gvim
set t_Co=256

" Different color modes for terminal vim and gvim respectively
if !has('gui_running')
  " Non-Gui (terminal) colors
  " colorscheme mustang
  " colorscheme railcasts
  " colorscheme monokai-chris
  " colorscheme 256-jungle
  " colorscheme railscasts
  colorscheme Tomorrow-Night
  " colorscheme distinguished
  " colorscheme jellybeans
else
  " GUI colors
  colorscheme twilight
endif

" Remove menu bar
set guioptions-=m

" Remove toolbar
set guioptions-=T

" Remove right-hand scroll bar
set guioptions-=r

" Remove left-hand scroll bar
set guioptions-=L

" Set relative number
set relativenumber

" Relative but still display actual current number line
set number

" Turn on syntax checking
syntax on

" Set two spaces indentation
set expandtab
set shiftwidth=2
set softtabstop=2

"Auto indent
set ai

"Smart indent
set si

"Wrap lines
set wrap

" Highlighting over-80 line
set colorcolumn=80

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" eof - end of section mark for convenient jump "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Utilities
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" -----------------------------------------------------------------------------
" + Open a web-browser with the URL in the current line
" -----------------------------------------------------------------------------

" http://vim.wikia.com/wiki/Open_a_web-browser_with_the_URL_in_the_current_line
function! Browser ()
  let line0 = getline (".")
  let line = matchstr (line0, "http[^ ]*")
  :if line==""
  let line = matchstr (line0, "ftp[^ ]*")
  :endif
  :if line==""
  let line = matchstr (line0, "file[^ ]*")
  :endif
  let line = escape (line, "#?&;|%")
  :if line==""
  let line = "\"" . (expand("%:p")) . "\""
  :endif
  exec ':silent !firefox ' . line
endfunction
map \w :call Browser ()<CR>

" -----------------------------------------------------------------------------
" + Remove all trailing whitespace by pressing F5
" -----------------------------------------------------------------------------

" http://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" -----------------------------------------------------------------------------
" + Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
" -----------------------------------------------------------------------------
nnoremap <C-j> :<C-u>silent! move+<CR>==
nnoremap <C-k> :<C-u>silent! move-2<CR>==
xnoremap <C-k> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <C-j> :<C-u>silent! '<,'>move'>+<CR>gv=gv

" -----------------------------------------------------------------------------
" + Delete trailing white space on save, useful for Python and CoffeeScript ;)
" -----------------------------------------------------------------------------
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" -----------------------------------------------------------------------------
" + Open the last closed split with Ctrl+t
" -----------------------------------------------------------------------------

"http://stackoverflow.com/questions/8184001/vim-reopen-last-closed-window-that-was-in-split
nmap <c-t> :vs<bar>:b#<CR>

" eof - end of section mark for convenient jump "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management with vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ????  Find it yourself
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'The-NERD-tree'
Plugin 'EasyMotion'
" Plugin 'Syntastic'
Plugin 'closetag.vim'
Plugin 'xmledit'
Plugin 'Filesearch'
Plugin 'zoom.vim'
Plugin 'Command-T'
Plugin 'bash-support.vim'
Plugin 'vim-airline'
Plugin 'vim-misc'
Plugin 'vim-session'
Plugin 'vim-flake8'
Plugin 'ctrlp.vim'
Plugin 'tComment'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" eof - end of section mark for convenient jump "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" -----------------------------------------------------------------------------
" + NERDTREE
" -----------------------------------------------------------------------------

" Set nerdtree menu to the right
let g:NERDTreeWinPos = "right"

" Map nerdtree toggle shortcuts
silent! nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" Open NerdTree with respect to current opened file
map <leader>r :NERDTreeFind<cr> 

" eof - end of section mark for convenient jump "

" -----------------------------------------------------------------------------
" + VIM-SESSION
" -----------------------------------------------------------------------------

" Make vim-session remember its window's last position
set sessionoptions+=resize,winpos

" Make vim-session auto save its state on window close
let g:session_autosave = 'yes'

" Make vim-session auto autoload its last session
let g:session_autoload = 'yes'

" eof - end of section mark for convenient jump "
