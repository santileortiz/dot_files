" Indentation configuration
set autoindent 
set cindent 
set tabstop=2
set shiftwidth=2
set expandtab
set cino+=(0

setlocal smartindent

" highlight matching braces
setlocal showmatch
" This avoids % matching { inside comments (Why is this not the default?!?!)
runtime macros/matchit.vim

" C like comment functionality
setlocal comments=b://
setlocal fo+=ro
