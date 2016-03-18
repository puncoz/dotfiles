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
set number

" highlight characters past 79 chars
match ErrorMsg '\%>79v.\+'

" source $MYVIMRC from inside nvim
nnoremap <leader>ev :split $MYVIMRC<CR>  
nnoremap <leader>sv :source $MYVIMRC<CR>  
