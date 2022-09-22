" Vim syntax file

" tuning parameters:
" unlet sdbuff_fold

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'sdbuff'
elseif exists("b:current_syntax") && b:current_syntax == "sdbuff"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


syn keyword sdbuffCommentTodo      TODO FIXME XXX TBD contained
syn match   sdbuffLineComment      "\/\/.*" contains=@Spell,sdbuffCommentTodo
syn match   sdbuffCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  sdbuffComment	       start="/\*"  end="\*/" contains=@Spell,sdbuffCommentTodo
syn match   sdbuffSpecial	       "\\\d\d\d\|\\."
syn region  sdbuffStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=sdbuffSpecial,@htmlPreproc
syn region  sdbuffStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=sdbuffSpecial,@htmlPreproc
syn region  sdbuffStringT	       start=+`+  skip=+\\\\\|\\`+  end=+`+	contains=sdbuffSpecial,sdbuffEmbed,@htmlPreproc

syn region  sdbuffEmbed	       start=+${+  end=+}+	contains=@sdbuffEmbededExpr

syn match   sdbuffSpecialCharacter "'\\.'"
syn match   sdbuffNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn match   sdbuffNumber	       "-\=\<\d\+\%(_\d\+\)*\>"

syn match   sdbuffPassiveEffect        "\<\(HealthChangeOT\|RunSpeed\|HealthLoss\|HealthMaxBlockage\)\>"

syn keyword sdbuffConditional	if else switch
syn keyword sdbuffRepeat		while for do in
syn keyword sdbuffBranch		break continue
syn keyword sdbuffStatement		return with await
syn keyword sdbuffBoolean		true false
syn keyword sdbuffNull		null undefined
syn keyword sdbuffState		begin main loop end events
syn keyword sdbuffInternalFunction		HasBuff NotHasBuff

syn cluster  sdbuffEmbededExpr	contains=sdbuffBoolean,sdbuffNull,sdbuffStringD,sdbuffStringS,sdbuffStringT
syn match	sdbuffFunction	"\<buff\>"
syn match	sdbuffParens	   "[()]"

if main_syntax == "sdbuff"
  syn sync fromstart
  syn sync maxlines=100

  syn sync ccomment sdbuffComment
endif

" Define the default highlighting.
" Only when an item doesn't have highlighting yet
hi def link sdbuffComment		Comment
hi def link sdbuffLineComment		Comment
hi def link sdbuffCommentTodo		Todo
hi def link sdbuffSpecial		Special
hi def link sdbuffStringS		String
hi def link sdbuffStringD		String
hi def link sdbuffStringT		String
hi def link sdbuffCharacter		Character
hi def link sdbuffSpecialCharacter	javaScriptSpecial
"hi def link sdbuffNumber		javaScriptValue
hi sdbuffNumber		ctermfg=231 ctermbg=16
hi def link sdbuffConditional		Conditional
hi def link sdbuffRepeat		Repeat
hi def link sdbuffBranch		Conditional
hi def link sdbuffStatement		Statement
hi def link sdbuffFunction		Function
hi def link sdbuffBraces		Function
hi def link sdbuffNull			Keyword
hi def link sdbuffBoolean		Boolean

"hi def link sdbuffState		Exception
hi sdbuffState ctermfg=3
hi def link sdbuffInternalFunction	Conditional
hi def link sdbuffDebug		Debug
hi def link sdbuffConstant		Label
hi def link sdbuffEmbed		Special
hi sdbuffPassiveEffect    ctermfg=214



let b:current_syntax = "sdbuff"
if main_syntax == 'sdbuff'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
