"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Simple vim config
" Usecase: Mainly for when I need to SSH into barebones server
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Settings
set nohlsearch
set hidden
set number
set relativenumber
set scrolloff=3
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set encoding=utf-8
set clipboard=unnamedplus
set laststatus=2
set noshowmode
set splitright
set splitbelow
set nowrap
set termguicolors
set colorcolumn=80
set ignorecase
set smartcase
set conceallevel=2
set nofoldenable

" Colorscheme
colorscheme desert

" Leader key
let mapleader = " "

" Mappings
inoremap jk <Esc>
nnoremap <leader>w <C-w>
nnoremap <leader>cdi :exe 'cd ' . fnamemodify($MYVIMRC, ':p:h')<CR>:e $MYVIMRC<CR>
nnoremap <leader>cdf :cd %:p:h<CR>
nnoremap <leader>mt :tabnew<CR>
vnoremap a' 2i'
vnoremap a" 2i"
vnoremap a` 2i`
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
nnoremap gh ^
nnoremap gl $
inoremap '  ''<left>
inoremap `  ``<left>
inoremap "  ""<left>
inoremap {  {}<left>
inoremap (  ()<left>
inoremap [  []<left>
inoremap {<CR> {<CR>}<ESC>O
nnoremap <S-Right> :vertical resize +2<CR>
nnoremap <S-Left>  :vertical resize -2<CR>
nnoremap <S-Up>    :resize +2<CR>
nnoremap <S-Down>  :resize -2<CR>
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :close<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>
nnoremap <leader>qf :cfirst<CR>
nnoremap <leader>ql :clast<CR>
nnoremap <leader>bu :make<CR>
xnoremap <leader>me :s/.*/\=eval(submatch(0))<CR>
inoremap <C-c> <Esc>
