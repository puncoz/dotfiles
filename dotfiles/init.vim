call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'nanotech/jellybeans.vim'

" git
Plug 'airblade/vim-gitgutter'

call plug#end()

let mapleader = ","
imap jk <Esc>

colorscheme jellybeans
set background=dark

" show characters past 79 chars long in red 
match ErrorMsg '\%>80v.\+'

" source 'init.vim' from inside nvim
nnoremap <leader>ev :split $MYVIMRC<CR>  
nnoremap <leader>sv :source $MYVIMRC<CR>  
