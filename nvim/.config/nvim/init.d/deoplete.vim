let g:deoplete#enable_at_startup = 1
" using only tab
" autoclose sratch pad
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

