set conceallevel=2
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_folding_level = 0
let g:vim_markdown_folding_style_pythonic = 1
set nofoldenable

function! OpenPreview(url)
  :call system('chromium --profile-directory="Profile 1" ' . a:url)
endfunction

let g:mkdp_browser='chromium'
