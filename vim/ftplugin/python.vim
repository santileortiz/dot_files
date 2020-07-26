" Insert # after adding a new line inside a comment
" TODO: For some reason if the comment starts with NOTE: the next comment line
" gets indented which may be annoying.
setlocal fo+=ro

" Runs the current file with CTRL-\
nnoremap  :!clear<CR>:cd %:h<CR>:!python3 '%'<CR>

" Map YCM's go to definition function
nmap <leader>jd :YcmCompleter ft=py GoToDefinitionElseDeclaration<CR>

" Mapping to close comments
inoremap <buffer> """ """"""hhi

" Mapping to close function documentation when writing )
inoremap <buffer> ) )za
