call DefineCustomSyntaxCommentAnnotations()

syntax clear pythonComment
syntax match pythonComment "#.*$" contains=customTodo,customNote,customFixme,customCaution,@Spell
