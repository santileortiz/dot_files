nmap <buffer> f /▸\s
nmap <buffer> F ?▸\s
"function! s:NERDJump(search, backwards)
"	if a:backwards
"		":silent! :exe '?\c\(|\|`\)\(\~\|+\|-\)'.a:search
"		:execute '/\s '.a:search.'<CR>'
"	else
"		:execute '?\s '.a:search.'<CR>'
"		":silent! :exe '/\c\(|\|`\)\(\~\|+\|-\)'.a:search
"	end 
"endfunction

"Quick jump to first item starting with X
"function! s:NERDJump(search, backwards)
"	if a:backwards
"		:silent! :exe '?\s'.a:search.'<CR>'
"	else
"		:silent! :exe '/\s'.a:search.'<CR>'
"	end 
"endfunction
"command! -nargs=* NERDJump call s:NERDJump(<f-args>)
"
"" Search forwards
"nmap <buffer> na :NERDJump a 0<CR>
"nmap <buffer> nb :NERDJump b 0<CR>
"nmap <buffer> nc :NERDJump c 0<CR>
"nmap <buffer> nd :NERDJump d 0<CR>
"nmap <buffer> ne :NERDJump e 0<CR>
"nmap <buffer> nf :NERDJump f 0<CR>
"nmap <buffer> ng :NERDJump g 0<CR>
"nmap <buffer> nh :NERDJump h 0<CR>
"nmap <buffer> ni :NERDJump i 0<CR>
"nmap <buffer> nj :NERDJump j 0<CR>
"nmap <buffer> nk :NERDJump k 0<CR>
"nmap <buffer> nl :NERDJump l 0<CR>
"nmap <buffer> nm :NERDJump m 0<CR>
"nmap <buffer> nn :NERDJump n 0<CR>
"nmap <buffer> no :NERDJump o 0<CR>
"nmap <buffer> np :NERDJump p 0<CR>
"nmap <buffer> nq :NERDJump q 0<CR>
"nmap <buffer> nr :NERDJump r 0<CR>
"nmap <buffer> ns :NERDJump s 0<CR>
"nmap <buffer> nt :NERDJump t 0<CR>
"nmap <buffer> nu :NERDJump u 0<CR>
"nmap <buffer> nv :NERDJump v 0<CR>
"nmap <buffer> nw :NERDJump w 0<CR>
"nmap <buffer> nx :NERDJump x 0<CR>
"nmap <buffer> ny :NERDJump y 0<CR>
"nmap <buffer> nz :NERDJump z 0<CR>
"
"" Search backwards
"nmap <buffer> <C-k>a :nerdjump a 1<cr>
"nmap <buffer> <C-k>b :NERDJump b 1<CR>
"nmap <buffer> <C-k>c :NERDJump c 1<CR>
"nmap <buffer> <C-k>d :NERDJump d 1<CR>
"nmap <buffer> <C-k>e :NERDJump e 1<CR>
"nmap <buffer> <C-k>f :NERDJump f 1<CR>
"nmap <buffer> <C-k>g :NERDJump g 1<CR>
"nmap <buffer> <C-k>h :NERDJump h 1<CR>
"nmap <buffer> <C-k>i :NERDJump i 1<CR>
"nmap <buffer> <C-k>j :NERDJump j 1<CR>
"nmap <buffer> <C-k>k :NERDJump k 1<CR>
"nmap <buffer> <C-k>l :NERDJump l 1<CR>
"nmap <buffer> <C-k>m :NERDJump m 1<CR>
"nmap <buffer> <C-k>n :NERDJump n 1<CR>
"nmap <buffer> <C-k>o :NERDJump o 1<CR>
"nmap <buffer> <C-k>p :NERDJump p 1<CR>
"nmap <buffer> <C-k>q :NERDJump q 1<CR>
"nmap <buffer> <C-k>r :NERDJump r 1<CR>
"nmap <buffer> <C-k>s :NERDJump s 1<CR>
"nmap <buffer> <C-k>t :NERDJump t 1<CR>
"nmap <buffer> <C-k>u :NERDJump u 1<CR>
"nmap <buffer> <C-k>v :NERDJump v 1<CR>
"nmap <buffer> <C-k>w :NERDJump w 1<CR>
"nmap <buffer> <C-k>x :NERDJump x 1<CR>
"nmap <buffer> <C-k>y :NERDJump y 1<CR>
"nmap <buffer> <C-k>z :NERDJump z 1<CR>
