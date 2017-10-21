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
Plugin 'L9'


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

" Disable mouse support (This was the default setting in previous versions)
set mouse=
syntax on 
filetype plugin on
filetype indent on
"execute pathogen#infect()

set bg=dark

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set hlsearch	"highlights search results
hi CursorLine cterm=NONE ctermbg=6 ctermfg=white guibg=darkred guifg=white	"adjust cursor color
set cul       "highlights current line
set matchpairs+=<:>	"sets % to jump between < and > . Command is 'set matchpairs+=', params are <:>,...,..
			"pairs separator ','  characted separator ':'
"autocmd Filetype html setlocal ts=2 sts=2 sw=2
"autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

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
ino ' ''<ESC>i
ino " ""<ESC>i
nn go o<ESC>k
nn gO O<ESC>j
ino ( ()<ESC>i
"no { {<ESC>o}<ESC>O
ino [ []<ESC>i
