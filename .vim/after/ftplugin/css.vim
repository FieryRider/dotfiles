set fileformat=unix
set encoding=utf-8
set expandtab
"set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd BufWritePost *.scss :silent call ConvertToCss()

fun! ConvertToCss()
  if expand('%:t') == 'style.scss' || expand('%:t') == 'styles.scss'
    execute "!sassc -t expanded " . expand('%:r') . "." . expand('%:e') expand('%:r') . ".css"
  else
    let current_file = expand('%:p')
    let project_dir = current_file[:match(current_file, 'styles\/') - 1]
    if filereadable(project_dir . 'style.scss')
      execute '!sassc -t expanded ' . project_dir . 'style.scss' . ' ' . project_dir . 'style.css'
    elseif filereadable(project_dir . 'styles.scss')
      execute '!sassc -t expanded ' . project_dir . 'styles.scss' . ' ' . project_dir . 'styles.css'
    endif
  endif
endfun
