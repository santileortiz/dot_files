" use intelligent indentation for C
setlocal smartindent
setlocal textwidth=80

" Indent struct initialization correctly.
setlocal indentexpr=GetMyCIndent()
function! GetMyCIndent()
    let theIndent = cindent(v:lnum)

    let m = matchstr(getline(v:lnum - 1),
    \                '^\s*\w\+\s\+\S\+.*=\s*{\ze[^;]*$')
    if empty(m)
        let m = matchstr(getline(v:lnum - 1),
        \                '^\s*\w\+\s\+\S\+.*=\s*{\ze[^;]*$')
    if !empty(m)
        let theIndent = len(m)
    endif

    return theIndent
endfunction
set cino=(0,W1s,m1

" highlight matching braces
setlocal showmatch
" intelligent comments
setlocal comments=sl:/*,mb:\ *,elx:\ */

" switch between header/source
noremap <buffer> <leader>c :FSHere<CR>
noremap <buffer> <leader>C <C-W>w:FSHere<CR><C-W>w

" Abbreviations
inoremap <buffer> <c-j> <Esc>/<++><CR><Esc>cf>
abbrev <buffer> prf printf ("<++>);<Esc>F(li

" cycle through compilation errors
noremap <leader>n :cn<CR>
noremap <leader>N :cp<CR>

" open makefile
nnoremap <buffer> <leader>em :e Makefile<CR>
nnoremap <buffer> <leader>et :vsplit $HOME/.vim/ftplugin/c.vim<cr>

" build using makeprg
function! MakeAndOpenQuickFixInVSplit()
    cclose
    let curr_win_num = winnr()
    if winnr('$') == 1
        vsplit
    else
        wincmd w
    endif
    let to_close = winnr()

    redraw
    copen
    exec to_close . "wincmd c"
    exec curr_win_num . "wincmd w"

    silent make
endfunction
noremap <buffer> <leader>m :call MakeAndOpenQuickFixInVSplit()<CR>
setlocal makeprg=bash\ -ic\ 'makehead\ %'

function! OpenTagInVSplit(JumpToTag)
    let curr_win_num = winnr()
    let cursor_word = expand('<cword>')
    if winnr('$') == 1
        vsplit
    else
        wincmd w
    endif

    exec "tjump " . cursor_word
    if (a:JumpToTag == 0)
        exec curr_win_num . "wincmd w"
    endif
endfunction

nnoremap <buffer> <A-]> :call OpenTagInVSplit(0)<CR>
nnoremap <buffer> <A-}> :call OpenTagInVSplit(1)<CR>

