call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'nanotech/jellybeans.vim'

" python
Plug 'klen/python-mode'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" whitespace trimmer for all file types
Plug 'ntpeters/vim-better-whitespace'

" navigation
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'ervandew/supertab'

" GNU/Linux utils
Plug 'vim-utils/vim-man'

" Github
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'

" completions
Plug 'Shougo/deoplete.nvim'

call plug#end()

let mapleader = ","
imap jk <Esc>
colorscheme jellybeans

" options galore
set background=dark
set number
set cursorline
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.pyc,/.venv/*

" highlight characters past 79 chars
match ErrorMsg '\%>79v.\+'

" strip whitespace on file save
autocmd BufWritePre * StripWhitespace

" edit/save $MYVIMRC conveniently
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" vim-plug mappings
nnoremap <leader>pi :PlugInstall <CR>
nnoremap <leader>pc :PlugClean <CR>

" vim-fugitive mappings
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Gcommit --verbose<CR>
nnoremap <silent> <leader>gam :Gcommit --verbose --amend<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gbw :Gbrowse<CR>

" nerdtree mappings
map ,<C-n> :NERDTreeToggle<CR>
let g:nerdtree_tabs_autoclose=1
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_smart_startup_focus=2
let g:nerdtree_tabs_startup_cd=1

" ctrl-p mappings
nnoremap <Leader>cf :CtrlPFunky<Cr>
nnoremap <leader>ct :CtrlPTag<cr>

" deo-plete
let g:deoplete#enable_at_startup=1

let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']
let g:ctrlp_cache_dir = $HOME . '.cache/ctrlp'
let g:ctrlp_use_caching = 1
let g:ctrlp_by_filename = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_height=30
let g:ctrlp_max_files = 5000
let g:ctrlp_max_depth = 100
let g:ctrlp_lazy_update = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_extensions = ['funky', 'tag']

" git.io/vai8m
function! MyFollowSymlink(...)
  if exists('w:no_resolve_symlink') && w:no_resolve_symlink
    return
  endif
  if &ft == 'help'
    return
  endif
  let fname = a:0 ? a:1 : expand('%')
  if fname =~ '^\w\+:/'
    " Do not mess with 'fugitive://' etc.
    return
  endif
  let fname = simplify(fname)
  let resolvedfile = resolve(fname)
  if resolvedfile == fname
    return
  endif
  let resolvedfile = fnameescape(resolvedfile)
  let sshm = &shm
  set shortmess+=A
  redraw
  exec 'file ' . resolvedfile
  let &shm=sshm
  unlet! b:git_dir
  call fugitive#detect(resolvedfile)
  if &modifiable
    redraw
    echomsg 'Resolved symlink: =>' resolvedfile
  endif
endfunction
command! -bar FollowSymlink call MyFollowSymlink()
au BufReadPost * nested call MyFollowSymlink(expand('%'))
