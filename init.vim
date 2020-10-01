"Plugins
call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
call plug#end()

"Editor configuration
set autoread

set updatetime=100

set ruler
set number
set signcolumn=yes
set colorcolumn=81

set tabstop=4
set shiftwidth=4
set expandtab

set guicursor=n-v-c:block-Cursor
set guicursor+=i:block-Cursor
set cursorline

set spell
set nowrap

colorscheme gruvbox
set background=dark
let g:lightline = {'colorscheme': 'jellybeans',}
