set ts=2 sts=2 sw=2 expandtab

let g:sql_type_default = 'mysql'
"let g:dbext_default_profile_mySQL = 'type=MYSQL:user=root:passwd=admdb:dbname=mysql'
let g:dbext_default_profile = 'mySQL'

function SetSqlDb(name)
  let g:dbext_default_profile_mySQL = 'type=MYSQL:user=root:passwd=admdb:dbname=' . a:name
endfunction
