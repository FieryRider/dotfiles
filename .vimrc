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

Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'tomtom/tcomment_vim'
Bundle 'kana/vim-smartinput'
""Required for some of the functionality of unite.vim
"Bundle 'Shougo/vimproc'
""Advanced fuzzy-finder
"Bundle 'Shougo/unite.vim' 
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

"Enable line numbers
set rnu
set nu

"Syntax highlighting and indentation
syntax on 
set bg=dark
filetype plugin on
filetype indent on

set fileformat=unix
set encoding=utf-8

"@return pid: String: Parent PID of the given PID
function! GetPPID(pid)
  return system('echo $(ps -o ppid= '. a:pid .')')
endfunction

"@param pid: String: PID of the program
function! GetProgramName(pid)
  return system('echo $(ps -o comm= '. a:pid .')')
endfunction

"Sets different cursor in normal/insert mode
"@TERM_EMU - manially set if in ssh session
"&t_SI - start insert mode
"&t_EI - exit insert mode
if exists('$TERM_EMU')
  let TERM_EMU = $TERM_EMU
else
  if exists("$TMUX") || exists("$TMUX_PANE")
    let tmux_pid = system('echo $(tmux display-message -p "#{client_pid}")')
    let parent_shell_pid = GetPPID(tmux_pid)
  else
    let vim_pid = system('echo $PPID')
    let parent_shell_pid = GetPPID(vim_pid)
  endif

  while (substitute(GetProgramName(parent_shell_pid), '\n', '', '') == "sudo") || (substitute(GetProgramName(parent_shell_pid), '\n', '', '') == "sudoedit") || (substitute(GetProgramName(parent_shell_pid), '\n', '', '') == "bash") || (substitute(GetProgramName(parent_shell_pid), '\n', '', '') == "virsh") || (substitute(GetProgramName(parent_shell_pid), '\n', '', '') == "systemctl") || (substitute(GetProgramName(parent_shell_pid), '\n', '', '') == "sshd")
    let parent_shell_pid = GetPPID(parent_shell_pid)
  endwhile

  let term_emu_pid = parent_shell_pid
  let TERM_EMU = GetProgramName(term_emu_pid)
endif


if (TERM_EMU =~ 'gnome-terminal') || (TERM_EMU =~ 'tilda') || (TERM_EMU =~ 'xfce4-terminal')
  let &t_SI .= "\<Esc>[6 q"
  let &t_EI .= "\<Esc>[2 q"
  if v:version > 704 || v:version == 704 && has('patch687')
    let &t_SR .= "\<Esc>[4 q"
  endif
  " 1 or 0 -> blinking block
  " 2 -> solid block
  " 3 -> blinking underscore
  " 4 -> solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
elseif TERM_EMU =~ 'konsole'
  if exists("$TMUX") || exists("$TMUX_PANE")
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    if v:version > 704 || v:version == 704 && has('patch687')
      let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    endif
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    if v:version > 704 || v:version == 704 && has('patch687')
      let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    endif
    " 0 -> block
    " 1 -> vertical line
    " 2 -> underscore
  endif
endif

set hlsearch    "highlights search results
hi CursorLine cterm=NONE ctermbg=6 ctermfg=white guibg=darkred guifg=white      "adjust cursor color
set cul         "highlights current line

"Set in their own .vim files
"autocmd Filetype html setlocal ts=4 sts=4 sw=4
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
nn <Leader>e :Explore<CR>
nn <Leader>f :FufFile<CR>
nn go o<ESC>k
nn gO O<ESC>j
nn <leader>t :tabnew<CR>
nn <leader>w :tabclose<CR>
nn gn :tabnext<CR>
nn gp :tabprev<CR>
"ino <expr> <S-Tab> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"
"selection remains after indenting
vno < <gv
vno > >gv
"alt+,  move to prev line of same identation
nn g, :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
"alt+.  move to next line of same identation
nn g. :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
"""""End Remaps"""""
