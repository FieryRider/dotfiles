" vim::foldmethod=marker:foldmarker={{{,}}}
" {{{ Plug setup
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" {{{ Snipmate
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'
"
"" Optional:
"Plug 'honza/vim-snippets'
" }}}

"Plug 'vim-scripts/L9'
"Plug 'vim-scripts/FuzzyFinder'

"Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
"Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons' " not strictly required, but recommended
Plug 'MunifTanjim/nui.nvim'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'kana/vim-smartinput'
Plug 'alvan/vim-closetag', { 'for': ['xml', 'html'] }
Plug 'leafOfTree/vim-vue-plugin', { 'for': ['vue'] }
Plug 'mattn/webapi-vim', { 'for': ['html', 'html.handlebars', 'vue'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'html.handlebars', 'vue', 'javascriptreact', 'typescriptreact'] }
" Plug 'othree/vim-autocomplpop'
Plug 'vim-scripts/dbext.vim', { 'for': 'sql' }
Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'typescript' ] }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': [ 'javascript', 'typescript' ] }
"Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/nvim-cmp'
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'for': ['html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'html.handlebars', 'cs', 'xml', 'python', 'markdown'] }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.handlebars' }
Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }
"Plug 'davidhalter/jedi-vim', { 'for': 'python' }
"Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile', 'for': ['javascriptreact', 'typescriptreact'] }

" {{{ Denite.vim
"Plug 'Shougo/denite.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
" }}}

"{{{ Markdown
Plug 'godlygeek/tabular', { 'for': 'markdown' }
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' }
"}}}

"{{{ C++
Plug 'rip-rip/clang_complete', { 'for': 'cpp' }
"}}}

"{{{ PHP
Plug 'ervandew/supertab', { 'for': 'php' }
Plug 'm2mdas/phpcomplete-extended', { 'for': 'php' }
"}}}

call plug#end()
" }}}

" {{{ Functions
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

" fun! GetBuffers()
"   let all = range(0, bufnr('$'))
"   let res = []
"   for b in all
"     let buf_status_name = printf('%s[%d]', fnamemodify(bufname(b), ':.'), bufnr(b))
"     if buflisted(b) && index(res, buf_status_name) == -1 && bufname(b) != @%
"       call add(res, buf_status_name)
"     endif
"   endfor
"   let bfs = ''.join(res, ' ')
"   return bfs
" endfun

function! List_match_re(list, to_be_matched, ...) abort
  let idx = (a:0>0) ? a:1 : 0

  while idx < len(a:list)
    if a:list[idx] =~ a:to_be_matched
      return a:list[idx]
    endif
    let idx += 1
  endwhile
  return v:null

  " The following doesn't improve performances significantly
  " let res = [-1]
  " call map(a:list[idx:], 'add(res, res[-1] >= 0 ? res[-1] : (match(a:to_be_matched, v:val)>=0 ? v:key : -1))')
  " return res[-1]+idx
endfunction

function! GetDefaultNvmVersion()
  let nvm_ver_file = $NVM_DIR . '/alias/default'
  let nvm_ver = readfile(nvm_ver_file)[0]
  let nvm_versions = (systemlist('ls ' . $NVM_DIR . '/versions/node'))
  let nvm_version = List_match_re(nvm_versions, 'v' . nvm_ver . '.*')
  if nvm_version != v:null
    return nvm_version
  else
    return v:null
  endif
endfunction
" }}}

" {{{ NeoTree
let g:neo_tree_remove_legacy_commands = 1
lua require('config/neo_tree')
" }}}
" {{{ NvimTRee
"lua require('config/nvim_tree')
" }}}
" {{{ LSP
"lua << EOF
"require'lspconfig'.jedi_language_server.setup{}
"EOF
"
"lua require('plugins/compe-config')
" }}}
" {{{ Coc config
" let g:coc_global_extensions = ['coc-css', 'coc-emmet', 'coc-html', 'coc-json', 'coc-omnisharp', 'coc-pyright', 'coc-snippets', 'coc-tsserver', 'coc-vetur']

let nvm_version = GetDefaultNvmVersion()
if nvm_version != v:null
  let g:coc_node_path = $NVM_DIR . '/versions/node/' . nvm_version . '/bin/node'
endif
" }}}

" {{{ Standard config
set viminfo='100,<500,s100,h
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

" set statusline=%f%m%r\ %y\ \|\ %{GetBuffers()}\ %=\ [%n]\ %l,%c
" }}}

autocmd BufNewFile,BufRead * if &syntax == '' | set syntax=plain | endif
autocmd BufNewFile,BufRead * cd . "Set current dir as working dir in netrw

"Remove auto wrapping of comments
autocmd FileType * set formatoptions-=c

"Custom config for custom 7 Days To Die buffs language
autocmd BufNewFile,BufRead *.7dbuff set ft=sdbuff

"{{{ Autocomplete settings
set completeopt+=menu,menuone,noinsert
set completeopt-=preview
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? "\<lt>Down>" : '<C-n>'
"}}}

" {{{ Find related options
"Append all files in the current project to the path so they can be searched with find
set path+=**
"Bar on top displaying available file when tabbing through file with commands like :e and also enables wild globbing with :find
set wildmenu
"Ignore `node_modules` dir because it can slow `find` command a lot
set wildignore+=**/node_modules/**

set incsearch
set inccommand=nosplit
" }}}

" {{{ Highlight settings
set hlsearch    "highlights search results
hi CursorLine cterm=NONE ctermbg=235 ctermfg=NONE guibg=235 guifg=NONE      "adjust cursor color
set cul         "highlights current line
" }}}

" {{{ Cursor config
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
" }}}

" {{{ Remaps
let mapleader = "\\"

"no <down> <Nop>
"no <up> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"
"ino <down> <Nop>
"ino <up> <Nop>
"ino <left> <Nop>
"ino <right> <Nop>
"
"vn <down> <Nop>
"vn <up> <Nop>
"vn <left> <Nop>
"vn <right> <Nop>

nn ; :
nn : ;
nn <c-p> :call UpByIndent()<cr>
" nn <Leader>e :Explore .<CR>
nn <Leader>e :Neotree<CR>
nn <Leader>f :FufFile<CR>
nn go o<ESC>k
nn gO O<ESC>j
nn <leader>t :tabnew<CR>
nn <leader>w :tabclose<CR>
nn gn :tabnext<CR>
nn gp :tabprev<CR>
"prevents the yanking of text that is pasted over in visual mode
vn p "_dP
"selection remains after indenting
vn < <gv
vn > >gv
"g+,  move to prev line of same identation
nn g, :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
"g+.  move to next line of same identation
nn g. :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
"Same mappings as above but for visual mode
vn g, <Esc>:call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>m'gv''
vn g. <Esc>:call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>m'gv''
"Search selected
vn // y/\V<C-R>=escape(@",'/\')<CR><CR>
" }}}
