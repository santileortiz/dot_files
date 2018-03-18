" Set colorscheme
colorscheme xoria256
" Runs the current file with CTRL-\
nnoremap  :!clear<CR>:cd %:h<CR>:!python3 '%'<CR>

" Enable line numbering
set number

" Map YCM's go to definition function
nmap <leader>jd :YcmCompleter ft=py GoToDefinitionElseDeclaration<CR>

" Mapping to close comments
inoremap <buffer> """ """"""hhi

" Mapping to close function documentation when writing )
inoremap <buffer> ) )za
