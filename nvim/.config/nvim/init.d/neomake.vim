autocmd! BufReadPost,BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_warning_sign = {'text': 'W', 'texthl': 'WarningMsg'}
let g:neomake_error_sign = {'text': 'E', 'texthl': 'ErrorMsg'}
let g:neomake_python_enabled_makers = []
