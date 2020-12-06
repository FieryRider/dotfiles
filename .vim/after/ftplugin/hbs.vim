set fileformat=unix
set filetype=html
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

"inoremap <tab> <c-r>=Smart_TabComplete()<CR>
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"

let g:user_emmet_expandabbr_key = '<C-a>'
