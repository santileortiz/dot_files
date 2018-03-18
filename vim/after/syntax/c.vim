syntax match cNote contained  "NOTE:"
syntax cluster cCommentGroup    add=cNote
highlight def link cNote        Note

syntax clear cTodo
syntax match cTodo contained "TODO:"
syntax match cFixme contained "\(FIXME\|XXX\):"
syntax cluster	cCommentGroup	add=cFixme
highlight def link cFixme		Fixme
