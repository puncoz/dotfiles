call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'nanotech/jellybeans.vim'

" python
Plug 'Raimondi/delimitMate'
Plug 'hynek/vim-python-pep8-indent'
Plug 'davidhalter/jedi-vim'

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

" static analysis
Plug 'benekastah/neomake'

" manipulation
Plug 'tpope/vim-commentary'

call plug#end()

let mapleader = ","
imap jk <Esc>
colorscheme jellybeans

" options galore
set background=dark
set number
set cursorline
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.pyc,/.venv/*
set laststatus=2
set completeopt=menuone,preview,noinsert
set wrap!

" terminal mode mappings
tnoremap jk <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" python specific
syntax enable
let python_highlight_all = 1
set number showmatch
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent

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

" git gutter, going big
let g:gitgutter_max_signs=10000

" vim-fugitive mappings {
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Gcommit --verbose<CR>
nnoremap <silent> <leader>gam :Gcommit --verbose --amend<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gbw :Gbrowse<CR>
" }

" nerdtree mappings {
map ,<C-n> :NERDTreeToggle<CR>
let g:nerdtree_tabs_autoclose=1
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_smart_startup_focus=2
let g:nerdtree_tabs_startup_cd=1
" }

" ctrl-p mappings/settings {
nnoremap <Leader>cf :CtrlPFunky<Cr>
nnoremap <leader>ct :CtrlPTag<cr>
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
" }

" deo-plete {
let g:deoplete#enable_at_startup=1
" }

" neomake {
let g:neomake_python_enabled_maker = ['flake8', 'pep8', 'mccabe']
let g:neomake_open_list=1
" }

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" delimitMate correction for triple quotes
au FileType python let b:delimitMate_nesting_quotes = ['"']

" disable auto commenting
au FileType * setlocal formatoptions-=cro

" jedi mappings/settings {
let g:jedi#usages_command=""
let g:jedi#popup_select_first=0
let g:jedi#use_tabs_not_buffers=1
let g:jedi#show_call_signatures="2"
let g:jedi#auto_close_doc=1
let g:jedi#goto_assignments_command = "<leader>pa"
let g:jedi#goto_definitions_command = "<leader>pd"
let g:jedi#documentation_command = "<leader>pk"
let g:jedi#usages_command = "<leader>pu"
let g:jedi#rename_command = "<leader>pr"
" }

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
