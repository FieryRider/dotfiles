if &ft == "markdown"
  finish
endif

set fileformat=unix
set encoding=utf-8
set expandtab
"set tabstop=4
set shiftwidth=4
set softtabstop=4
"set omnifunc=htmlcomplete#CompleteTags
let g:html_indent_tags = 'li\|p'

set matchpairs+=<:>	"sets % to jump between < and > . Command is 'set matchpairs+=', params are <:>,...,..
			"pairs separator ','  characted separator ':'

nn <leader>c :exe ':silent !chromium % &'<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
