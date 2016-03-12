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
"    - Pllugin management with vundle
"    - Pllugin configurations
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

" " Set tab title current file name
" set guitablabel=%t
"
" Set dark background for all colorscheme
set background=dark

" Making terminal vim have the same colorscheme as in gvim
set t_Co=256

" Different color modes for terminal vim and gvim respectively
if !has('gui_running')
  " Non-Gui (terminal) colors
  colorscheme mustang
  " colorscheme railcasts
  " colorscheme monokai-chris
  " colorscheme 256-jungle
  " colorscheme railscasts
  " colorscheme Tomorrow-Night
  " colorscheme distinguished
  " colorscheme jellybeans
else
  " GUI colors
  " colorscheme solarized 
  " colorscheme railcasts
  " colorscheme monokai-chris
  " colorscheme 256-jungle
  " colorscheme railscasts
  colorscheme Tomorrow-Night
  " colorscheme distinguished
  " colorscheme jellybeans
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

set ai
"Auto indent

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

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

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
" xnoremap <C-k> :<C-u>silent! '<,'>move-2<CR>gv=gv
" nnoremap <C-k> :<C-u>silent! move-2<CR>==
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
Plugin 'tComment'
Plugin 'surround.vim'
Plugin 'html-xml-tag-matcher'
Plugin 'MatchTagAlways'
Plugin 'neocomplete.vim'
Plugin 'neosnippet.vim'
Plugin 'neosnippet-snippets'
Plugin 'vim-fugitive'
Plugin 'vim-bookmarks'
Plugin 'ack.vim'
Plugin 'delimitMate.vim'
Plugin 'SearchComplete'
Plugin 'CSApprox'
" Plugin 'YouCompleteMe'
" eof - end of section mark for convenient jump "
" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -----------------------------------------------------------------------------
" + YouCompleteMe 
" -----------------------------------------------------------------------------
" let g:ycm_seed_identifiers_with_syntax=1
" let g:ycm_global_ycm_extra_conf = '/home/li/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
" let g:ycm_confirm_extra_conf=0
" let g:ycm_collect_identifiers_from_tag_files = 1
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" set completeopt=longest,menu

" -----------------------------------------------------------------------------
" + neocomplete.vim 
" -----------------------------------------------------------------------------
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" eof - end of section mark for convenient jump "
" -----------------------------------------------------------------------------
" + neosnippet 
" -----------------------------------------------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" eof - end of section mark for convenient jump "
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
" -----------------------------------------------------------------------------
" + NERDTREE
" -----------------------------------------------------------------------------
" let g:bookmark_auto_save_file = '/bookmarks'
" highlight BookmarkSign ctermbg=NONE ctermfg=160
" highlight BookmarkLine ctermbg=194 ctermfg=NONE
" let g:bookmark_sign = '♥'
" let g:bookmark_highlight_lines = 1
" eof - end of section mark for convenient jump "
