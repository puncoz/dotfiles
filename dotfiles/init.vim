set nocompatible

call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'

" haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'eagletmt/neco-ghc'

" programming
Plug 'Raimondi/delimitMate'

" python
Plug 'hynek/vim-python-pep8-indent', {'for' : ['python']}
Plug 'davidhalter/jedi-vim', {'for' : ['python']}
Plug 'gotcha/vimpdb', {'for' : ['python']}
Plug 'fisadev/vim-isort', {'for' : ['python']}

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

" motion
Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'

" GNU/Linux utils
Plug 'vim-utils/vim-man'

" Github
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'

" completions
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips',
Plug 'honza/vim-snippets'

" static analysis
Plug 'benekastah/neomake'

" manipulation
Plug 'tpope/vim-commentary'

" quickfix
Plug 'tpope/vim-unimpaired'

call plug#end()

let mapleader = ","
imap jk <Esc>

" colorschemes
colorscheme molokai
set background=dark

" colorscheme solarized
" let g:solarized_termcolors=256

" options galore
syntax on
filetype plugin indent on

set number
set cursorline
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.pyc,/.venv/*
set completeopt=menuone,preview,noinsert
set wrap!
set incsearch
set ignorecase
set textwidth=0
set nobackup
set nowritebackup
set noswapfile
set history=999
set backspace=indent,eol,start
set ruler
set showmode
set laststatus=2
set scrolloff=10
set ch=2
set hlsearch
set gdefault
set hidden
set whichwrap+=<,>,[,]
set wildmenu
set title
set ttyfast
set virtualedit=onemore
set fileencodings=.
set spelllang=en_gb
set foldmethod=indent
set foldlevel=99
set relativenumber
set nohlsearch

" terminal mode mappings
if exists(':tnoremap')  " Neovim
  tnoremap jk <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " exit.
  tnoremap jk <C-\><C-n>

  " <c-space> does not work (https://github.com/neovim/neovim/issues/3101).
  tnoremap <C-@> <C-\><C-n>:tab sp<cr>:startinsert<cr>

  let g:terminal_scrollback_buffer_size = 100000  " current max

  nnoremap <Leader>cx :vsp \| :term envdir envdir ptw velodrome -- --testmon<cr>
  nnoremap <Leader>cX :vsp \| :term envdir envdir ptw velodrome -- --testmon<space>

  augroup vimrc_term
    au!
    autocmd! BufEnter term://* startinsert
  augroup END
endif

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
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" vim-plug mappings
nnoremap <leader>pi :PlugInstall <CR>
nnoremap <leader>pc :PlugClean <CR>

" git gutter, going big
let g:gitgutter_max_signs=10000
let g:gitgutter_realtime=1
let g:gitgutter_eager=1

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
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" }

" neomake {
let g:neomake_python_enabled_makers = ['pylama']
let g:neomake_open_list=1
let g:neomake_list_height=6

nnoremap <leader>qc :lclose<CR>
nnoremap <leader>qo :lopen<CR>

autocmd! BufWritePost * Neomake
" }

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" delimitMate correction for triple quotes
au FileType python let b:delimitMate_nesting_quotes = ['"']

" disable auto commenting
au FileType * setlocal formatoptions-=cro

" jedi mappings/settings {
let g:jedi#usages_command=""
let g:jedi#popup_select_first=1
let g:jedi#use_tabs_not_buffers=1
let g:jedi#show_call_signatures="2"
let g:jedi#auto_close_doc=1
let g:jedi#goto_assignments_command = "<leader>pa"
let g:jedi#goto_definitions_command = "<leader>pd"
let g:jedi#documentation_command = "<leader>pk"
let g:jedi#usages_command = "<leader>pu"
let g:jedi#rename_command = "<leader>pr"
" }

" isort mapping
let g:vim_isort_map = '<C-i>'

" tab mappings
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" close scratch window when getting into insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" gist mappings
nnoremap <leader>gl :Gist -l<CR>

" ultisnip mappings
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-k>"

" escape parens
inoremap <C-e> <C-o>a
inoremap <C-d> <C-o>A

" ultisnips {
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-k>"
" }

" specify python
let g:python_host_prog='/home/lwm/.pyenv/shims/python'

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
