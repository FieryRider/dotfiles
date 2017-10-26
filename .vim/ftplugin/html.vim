set tabstop=4
set shiftwidth=4
set softtabstop=4
"set expandtab
"set omnifunc=htmlcomplete#CompleteTags
let g:html_indent_tags = 'li\|p'

set matchpairs+=<:>	"sets % to jump between < and > . Command is 'set matchpairs+=', params are <:>,...,..
			"pairs separator ','  characted separator ':'

nn <leader>c :exe ':silent !chromium % &'<CR>

