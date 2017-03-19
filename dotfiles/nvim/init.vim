" Make sure changes follow symlinks
" https://github.com/tpope/vim-fugitive/issues/147#issuecomment-27607563
function! MyFollowSymlink(...)
  if exists('w:no_resolve_symlink') && w:no_resolve_symlink
    return
  endif
  if &ft == 'help'
    return
  endif
  let fname=a:0 ? a:1 : expand('%')
  if fname =~ '^\w\+:/'
    " Do not mess with 'fugitive://' etc.
    return
  endif
  let fname=simplify(fname)
  let resolvedfile=resolve(fname)
  if resolvedfile == fname
    return
  endif
  let resolvedfile=fnameescape(resolvedfile)
  let sshm=&shm
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

call plug#begin('~/.config/nvim/plugged')

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'

" Haskell HLint in-place refactoring
Plug 'mpickering/hlint-refactor-vim', {'for': 'haskell'}

" Haskell formatting (not opinionated)
Plug 'nbouscal/vim-stylish-haskell', {'for': 'haskell'}

" Haskell interactive development
Plug 'parsonsmatt/intero-neovim', {'for': 'haskell'}

" Docker syntax highlighting
Plug 'ekalinin/Dockerfile.vim'

" Ansible syntax highlighting
Plug 'chase/vim-ansible-yaml'

" Python PEP8 style enforcer
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

" Python completion library
Plug 'davidhalter/jedi-vim', {'for': 'python'}

" Python import statement sorting
Plug 'fisadev/vim-isort', {'for': 'python'}

" Python virtual environment support
Plug 'lambdalisue/vim-pyenv', {'for': 'python'}

" Git modification HUD
Plug 'airblade/vim-gitgutter'

" Git inside Vim
Plug 'tpope/vim-fugitive'

" Git syntax highlighting
Plug 'tpope/vim-git'

" File explorer tab controller
Plug 'jistr/vim-nerdtree-tabs'

" File explorer
Plug 'scrooloose/nerdtree'

" Fuzzy file searcher
Plug 'kien/ctrlp.vim'

" Fuzzy function searcher
Plug 'tacahiroy/ctrlp-funky'

" Completion library for quotes/parens/brackets
Plug 'Raimondi/delimitMate'

" White space killer
Plug 'ntpeters/vim-better-whitespace'

" Helper for making the TAB key work
Plug 'ervandew/supertab'

" Edit multiple words with ease
Plug 'terryma/vim-multiple-cursors'

" Jump to any word you can see
Plug 'Lokaltog/vim-easymotion'

" Manipulate things that surround things
Plug 'tpope/vim-surround'

" All round completion engine
Plug 'Shougo/deoplete.nvim'

" Bindings for commenting out things
Plug 'tpope/vim-commentary'

" Helpful mappings
Plug 'tpope/vim-unimpaired'

" EditorConfig is good
Plug 'editorconfig/editorconfig-vim'

" Async lint framework
Plug 'neomake/neomake'

" Status line prettifier
Plug 'rafi/vim-tinyline'

call plug#end()

" Standard Vim leader key for bindings
let mapleader=","

" Get out of insert mode with 'jk'
imap jk <Esc>
tnoremap jk <C-\><C-n>

" My favourite colour scheme
set background=dark
colorscheme gruvbox

" options galore {
" TODO: Comment these!!!
syntax on
filetype plugin indent on
set spell spelllang=en_gb
set number
set cursorline
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.pyc,/.venv/*
set completeopt=menuone,preview
set wrap!
set incsearch
set ignorecase
set textwidth=0
set wrapmargin=0
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
set listchars=tab:»·,trail:·,eol:¬,nbsp:_,extends:»,precedes:«
set list
set expandtab
set smartindent
set clipboard+=unnamedplus
set shiftwidth=2
set softtabstop=2
set tabstop=2
" }

" Stop automatically inserting comments on new lines
set formatoptions=

" Wrap and join an entire paragraph
nnoremap <leader>qa gqap

" Choose the first spell check recommendation
nnoremap <leader>Z 1z=

" escape parens {
inoremap <C-e> <C-o>a
inoremap <C-d> <C-o>A
" }

nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>pi :PlugInstall <CR>
nnoremap <leader>pc :PlugClean <CR>

" https://blog.mikecordell.com/vim/2014/07/20/quick-fixup-in-vim-with-fugitive.html {
nnoremap <leader>gl :Git! log<CR>ggw
nnoremap <leader>f yiw <ESC>:Gcommit --fixup=<C-r>"<CR>

let g:gitgutter_max_signs=10000
let g:gitgutter_realtime=1
let g:gitgutter_eager=1

" nerdtree {
map ,<C-n> :NERDTreeToggle<CR>
let g:nerdtree_tabs_autoclose=1
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_smart_startup_focus=2
let g:nerdtree_tabs_startup_cd=1
" }

" Enable line numbers in Nerdtree tabs
" http://www.mokacoding.com/blog/nerdtree-relative-numbers/
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

nnoremap <Leader>cf :CtrlPFunky<Cr>
nnoremap <leader>ct :CtrlPTag<cr>
let g:ctrlp_user_command=['.git/', 'cd %s && git ls-files --exclude-standard -co']
let g:ctrlp_cache_dir=$HOME . '.cache/ctrlp'
let g:ctrlp_use_caching=1
let g:ctrlp_by_filename=1
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=30
let g:ctrlp_max_files=5000
let g:ctrlp_max_depth=100
let g:ctrlp_lazy_update=1
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_extensions=['funky', 'tag']

" deo-plete {
let g:deoplete#enable_at_startup=1
let g:deoplete#enable_ignore_case=1
let g:deoplete#enable_smart_case=1
" }

" neomake {
let g:neomake_python_pylama_maker = {
    \ 'args': ['--format', 'pep8', '--ignore', 'W0401'],
    \ 'errorformat': '%f:%l:%c: %t%m',
    \ }
let g:neomake_python_enabled_makers=['pylama']
let g:neomake_haskell_enabled_makers=['hlint']
let g:neomake_open_list=2
let g:neomake_list_height=6
let g:neomake_verbose=1
let g:neomake_logfile='/tmp/neomake.log'
nnoremap <leader>qc :lclose<CR>
nnoremap <leader>qo :lopen<CR>
autocmd! BufWritePost * Neomake
" }

" supertab {
let g:SuperTabDefaultCompletionType="<c-n>"
let g:SuperTabLongestHighlight=1
" }

" delimitMate correction for triple quotes {
au FileType python let b:delimitMate_nesting_quotes=['"', "`"]
" }

" jedi {
let g:jedi#usages_command=""
let g:jedi#popup_select_first=1
let g:jedi#use_tabs_not_buffers=1
let g:jedi#show_call_signatures="2"
let g:jedi#auto_close_doc=1
" }

" vim-isort {
let g:vim_isort_map='<C-i>'
" }

" tab mappings {
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" }

" gist.vim {
nnoremap <leader>gt :Gist -c f17fdf2d1efe50379da5<CR>
" }

" ultisnips {
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-k>"
" }

" easymotion {
nmap <space> <Plug>(easymotion-s)
let g:EasyMotion_smartcase=1
let g:EasyMotion_use_upper=1
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First MatchParen
hi link EasyMotionTarget2Second MatchParen
hi link EasyMotionMoveHL Search
" }

" strip all that whitespace
autocmd BufWritePre * StripWhitespace

" python {
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
" }

" dictionary mappings {
nnoremap <Leader>dg :sp \| :term dict -d gcide<space>
nnoremap <Leader>dt :sp \| :term dict -d moby-thesaurus<space>
" }

" vim-ansible-yaml.vim {
let g:ansible_options={'ignore_blank_lines': 0}
" }

" dotfiles / docker / makefile mania {
nnoremap <Leader>D :sp \| :term make dockerize CMDS="make<space>
nnoremap <Leader>db :sp \| :term docker build -t lwm/xenial .<cr>
" }

" wrap lines in location list
au FileType qf set wrap
