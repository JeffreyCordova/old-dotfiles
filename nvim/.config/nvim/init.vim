"                _
"    ____ _   __(_)___ ___
"   / __ \ | / / / __ `__ \
"  / / / / |/ / / / / / / /
" /_/ /_/|___/_/_/ /_/ /_/
"

"---[Autoinstall]--------------------------------------------------------------
let CONFIGS = $XDG_CONFIG_HOME
if CONFIGS == ""
    let CONFIGS = $HOME . "/.config"
endif

if empty(glob(CONFIGS . '/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"---[Plug]---------------------------------------------------------------------

call plug#begin(CONFIGS . '/nvim/plugged')

" visual
Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

" file navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'thaerkh/vim-workspace'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'

" commenting
Plug 'scrooloose/nerdcommenter'

" automatic parentheses
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'bhurlow/vim-parinfer'

" autocompletion
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

" syntax check, task runner
Plug 'neomake/neomake'
Plug 'junegunn/fzf'
Plug 'scrooloose/syntastic'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" misc
Plug 'troydm/zoomwintab.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kshenoy/vim-signature'
Plug 'wesQ3/vim-windowswap'
Plug 'godlygeek/tabular'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" langs
Plug 'tmhedberg/SimpylFold'
Plug 'pangloss/vim-javascript'
Plug 'julialang/julia-vim'

call plug#end()

"---[Settings]-----------------------------------------------------------------

let mapleader="\<Space>"

" per project settings
set exrc
set secure

" syntax
set background=dark
colorscheme jellybeans
set cursorline

" turn on filetype
filetype plugin indent on
syntax enable

" reload on external change
set autoread

" remove vertical bar chars
" WARNING: trailing char is vital!
set fillchars+=vert:\ "

" tabs
set tabstop=4
set expandtab
set shiftwidth=4

set number

set foldmethod=syntax
set foldlevelstart=99

set backspace=indent,eol,start
set nowrap

" ruler options
set ruler
set cc=81
hi ColorColumn ctermbg=233

" show invisibiles
set list
set lcs+=eol:¬,extends:>,precedes:<,tab:»\ ,trail:·

set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8

" splitting
set splitbelow
set splitright

" wrapping
set linebreak

" scroll offset
set so=10

" search highlight
set hlsearch

" incremental substitute
set inccommand=split

" smart case in search
set ignorecase
set smartcase

" mouse support
set mouse=a
:map <MiddleMouse> <Nop>
:imap <MiddleMouse> <Nop>
:map <2-MiddleMouse> <Nop>
:imap <2-MiddleMouse> <Nop>
:map <3-MiddleMouse> <Nop>
:imap <3-MiddleMouse> <Nop>
:map <4-MiddleMouse> <Nop>
:imap <4-MiddleMouse> <Nop>

" sudo write
:command Suw :w !sudo tee %

"---[Plugins]------------------------------------------------------------------
for f in glob(CONFIGS . "/nvim/init.d/*.vim", 0, 1)
    execute 'source' f
endfor

"---[Mappings]-----------------------------------------------------------------
" nohl shortcut
nnoremap <silent> <Leader>/ :nohl<cr>

" pane resize shortcut
nnoremap <Leader>> <C-w>10>
nnoremap <Leader>< <C-w>10<
nnoremap <Leader>+ <C-w>10+
nnoremap <Leader>- <C-w>10-

" tags
nnoremap ]t :tnext<cr>
nnoremap [t :tprev<cr>

" deoplete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" nerdtree
nnoremap <silent> <Leader>f :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>

" nerdcommenter
"nnoremap <silent> <C-/> <Plug>NERDCommenterToggle

" tmux navigator
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>
" C-h is recognized as <BS> in nvim due to libtermkey
" see https://github.com/neovim/neovim/issues/2048
if has("nvim")
    nmap <BS> <C-H>
endif

" toggle wrap
map <leader>wt :call ToggleWrap()<cr>

" zoomwintab
nnoremap <silent> <Leader>z :ZoomWinTabToggle<cr>

