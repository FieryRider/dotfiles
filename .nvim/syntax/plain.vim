" Vim syntax file
" Language: generic configure file
" Maintainer FieryRider <github.com/ivailogeimara>
" Last Change: 02 Sep 2019

if exists("b:current_syntax")
  finish
endif

syn match   confComment   "^#.*"
syn match   confComment   "\s#.*"

hi def link confComment Comment

let b:current_syntax = "plain"

" vim: ts=8 sw=2
