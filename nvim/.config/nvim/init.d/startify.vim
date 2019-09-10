autocmd User Startified setlocal buftype=
hi StartifyHeader ctermfg=4
hi StartifyPath ctermfg=188
hi StartifySlash ctermfg=188
hi StartifyFile ctermfg=188
hi StartifyNumber ctermfg=4
hi StartifySection ctermfg=12
hi StartifyBracket ctermfg=188
let g:startify_change_to_dir=0
let g:startify_custom_header=
    \ map(split(system("figlet -f slant -w $COLUMNS Defeat the Machine"), '\n'),
    \ '" ".  v:val') + ['']

