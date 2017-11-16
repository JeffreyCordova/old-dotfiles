let NERDTreeShowHidden=0
hi NERDTreeDir ctermfg=188
hi NERDTreeFile ctermfg=188
hi NERDTreeExecFile ctermfg=188 cterm=bold
hi NERDTreeLinkFile ctermfg=4
hi NERDTreeDirSlash ctermfg=12
hi NERDTreeCWD ctermfg=12 cterm=bold
hi NERDTreeHelp ctermfg=188
hi link NERDTreeUp NERDTreeDir
hi link NERDTreeLinkDir NERDTreeLinkFile
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "+",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "-",
    \ "Dirty"     : "~",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

