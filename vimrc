set nocompatible
set backspace=indent,eol,start

"Vundle configuration
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

"let vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" My bundles here:
"Plugin 'Valloric/YouCompleteMe'
Plugin 'https://github.com/tpope/vim-surround'
"Plugin 'https://github.com/derekwyatt/vim-fswitch'
Plugin 'craigemery/vim-autotag'
Plugin 'joonty/vim-do.git'
Plugin 'tikhomirov/vim-glsl'
" original repos on GitHub
"Bundle 'Lokaltog/vim-easymotion'
"" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'
call vundle#end()
filetype plugin indent on     " required!

" Disable backup
set nobackup
set nowritebackup

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Set some search options
" set incsearch
set ignorecase
set smartcase

" Enable 256 color mode
set t_Co=256
colorscheme santi_xoria256
syntax on
set number

" Indentation configuration
set autoindent 
set cindent 
set tabstop=4 
set shiftwidth=4 
set expandtab
set cino+=(0

" Paragraph navigation with Space
noremap <Space> }
noremap <S-Space> {

nnoremap <C-a> "Ayy

" Misc mappings
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap x "cx
nnoremap <leader>a f,w
nnoremap <leader>A 2F,w
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
nnoremap <leader>8 yiw<C-w>w/\<<c-r>0\><CR>
nnoremap <leader>cw *Ncw

" Use these to select-delete-paste functions
vnoremap <leader>d di<cr><esc>
vnoremap <leader>p P

" Open file in vsplit
set splitright

" filename autocompletion
set wildmode=full
set wildmenu

" configuration to facilitate buffer switchinw
set hidden
set confirm

" enable mouse interaction
set mouse+=a
set selectmode-=mouse

"configure clipboard
set clipboard=unnamedplus

" CommandT mappings
noremap <leader>f :CommandT<CR>
let g:CommandTToggleFocusMap=''
let g:CommandTSelectNextMap='<Tab>'
let g:CommandTSelectPrevMap='<S-Tab>'

" Spell Checking
set nospell
set spelllang=en,es
set spellsuggest=5

" LaTeX configuration
let g:tex_flavor='latex'

" Gui setup (basically removes most of the GUI)
set guioptions -=T
set guioptions +=c
set guioptions -=e
set guioptions -=r
set guioptions -=b
set guioptions -=m
set guioptions -=L

function! InsertFormat()
    if @% =~ '\.[ch]$'
        0r ~/.vim/c_templ.c
        %s/<YEAR>/\=strftime("%Y")
    endif

    if @% =~ '\.h$'
        let s:libh = toupper(expand("%:r")).'_H'
        call append(line("$"), '#if !defined('.s:libh.')')
        call append(line("$"), '')
        call append(line("$"), '#define '.s:libh)
        call append(line("$"), '#endif')
    endif
endfunction

autocmd bufNewFile *.c,*.h call InsertFormat()

