autocmd BufWritePost *.scss :call ConvertToCss()

fun! ConvertToCss()
  execute "!sassc -t expanded " . expand('%:r') . "." . expand('%:e') expand('%:r') . ".css"
endfun
