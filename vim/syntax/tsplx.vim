syn keyword Label a
syn match   Label "[;.,\(^^\)]"

call DefineCustomSyntaxCommentAnnotations()
syn region  Comment           start="//"  end="$" contains=customTodo,customFixme,customNote,customCaution

syn region  turtleString      start=+"+  end=+"+
syn match   turtleNumber      "\([+-]\)\?\d\+\(\.\d\+\)\?"
syn match   turtleBoolean     "true\|false"
syn match   turtleDeclaration "@prefix"
syn match   turtleDeclaration "@prefix"
syn match   turtlePrefix      "[a-zA-Z0-9_]*:"
syn match   turtleIdentifier  ":\@<=[a-zA-Z0-9_-]*"
syn region  turtleURI         start=+<+ end=+>+ skip=+\\\\\|\\"+

highlight link turtleString          String
highlight link turtleBoolean         String
highlight link turtleNumber          Number
highlight link turtleDeclaration     PreCondit
highlight link turtlePrefix          Special
highlight link turtleIdentifier      Normal
highlight link turtleURI             Identifier
