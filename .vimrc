let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
syntax on
colorscheme mustang 
set background=dark
set t_Co=256

:imap jk <Esc>
let mapleader="\<Space>"
if !has('gui_running') 
  " GUI colors
  colorscheme monokai-chris  
else 
  " Non-Gui (terminal) colors
  colorscheme twilight 
endif

" Highlighting over80 line
" :set colorcolumn=80
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

set expandtab
set shiftwidth=2
set softtabstop=2

set number

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'The-NERD-tree'
Plugin 'EasyMotion'
Plugin 'Syntastic'
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
" Plugin 'jedi-vim'
"################################################ Start
Plugin 'tComment'
" gc{motion}   :: Toggle comments (for small comments within one line 
"                 the &filetype_inline style will be used, if 
"                 defined) 
" gcc          :: Toggle comment for the current line 
" gC{motion}   :: Comment region 
" gCc          :: Comment the current line 
"################################################ End

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Map nerdtree toggle shortcut
silent! nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

"copy to 'clipboard registry'
:behave mswin
:set clipboard=unnamedplus
:smap <Del> <C-g>"_d
:smap <C-c> <C-g>y
:smap <C-x> <C-g>x
:imap <C-v> <Esc>pi
:smap <C-v> <C-g>p
:smap <Tab> <C-g>1> 
:smap <S-Tab> <C-g>1<

" Number and relative number way of numbering line 
:set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

:set ignorecase
:set smartcase

" " Hightlight tab characters
" :set list
set sessionoptions+=resize,winpos
let g:NERDTreeWinPos = "right"

" Allow mouse to function in vim
set mouse=a

