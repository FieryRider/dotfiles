""""""""""""Vundle Init""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/L9'


"""""""""""End Vundle Init"""""""""""

"""""""""""Snipmate"""""""""""""
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Optional:
Plugin 'honza/vim-snippets'

"""""""""End SnipMate""""""""""""

""""""""""""""PHP"""""""""""""""
Bundle 'Shougo/vimproc'
Bundle 'Shougo/unite.vim'
Bundle 'ervandew/supertab'
Bundle 'm2mdas/phpcomplete-extended'
"""""""""""""End PHP""""""""""""

Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/FuzzyFinder'
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
"
" """""""""""""""""End Vundle"""""""""""""""""""""
" """"""""""""""""""""""""""""""""""""""""""""""""

"Disable mouse support (This was the default setting in previous versions)
set mouse=
set bg=dark

"Syntax highlighting and indentation
syntax on 
filetype plugin on
filetype indent on
"execute pathogen#infect()

"Sets different cursor in normal/insert mode
if &term =~ '^xterm'
  let &t_SI .= "\<Esc>[6 q"
  let &t_EI .= "\<Esc>[2 q"
"  " 1 or 0 -> blinking block
"  " 2 -> solid block
"  " 3 -> blinking underscore
"  " 4 -> solid underscore
"  " Recent versions of xterm (282 or above) also support
"  " 5 -> blinking vertical bar
"  " 6 -> solid vertical bar
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set hlsearch	"highlights search results
hi CursorLine cterm=NONE ctermbg=6 ctermfg=white guibg=darkred guifg=white	"adjust cursor color
set cul       "highlights current line
"autocmd Filetype html setlocal ts=2 sts=2 sw=2
"autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

"""""""Fuctions"""""""
fun! UpByIndent()
  norm! ^
  let start_col = col(".")
  let col = start_col
  while col >= start_col
    norm! k^
    if getline(".") =~# '^\s*$'
      let col = start_col
    elseif col(".") <= 1
      return
    else
      let col = col(".")
    endif
  endwhile
endfun

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the curren
t
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty st
ring
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_slash)
    return "\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  endif
endfunction

"""""End Functions"""""

"""""""Remaps"""""""
no <down> <Nop>
no <up> <Nop>
no <left> <Nop>
no <right> <Nop>

ino <down> <Nop>
ino <up> <Nop>
ino <left> <Nop>
ino <right> <Nop>

vno <down> <Nop>
vno <up> <Nop>
vno <left> <Nop>
vno <right> <Nop>

let mapleader = "\\"
nn ; :
nn : ;
nn <c-p> :call UpByIndent()<cr>
nn <Leader>n :NERDTree<CR>
nn <Leader>f :FufFile<CR>
nn go o<ESC>k
nn gO O<ESC>j
ino ' ''<ESC>i
ino " ""<ESC>i
ino ( ()<ESC>i
"ino { {<ESC>o}<ESC>O
ino [ []<ESC>i
"ino <tab> <c-r>=Smart_TabComplete()<CR>
"""""End Remaps"""""
