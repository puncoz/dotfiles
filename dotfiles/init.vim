set nocompatible

" functions
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" git.io/vai8m
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

Plug 'morhetz/gruvbox'
Plug 'itchyny/vim-haskell-indent', {'for': 'haskell'}
Plug 'jaspervdj/stylish-haskell', {'for': 'haskell'}
Plug 'mpickering/hlint-refactor-vim', {'for': 'haskell'}
Plug 'parsonsmatt/intero-neovim', {'for': 'haskell'}
Plug 'lambdatoast/elm.vim', {'for': 'elm'}
Plug 'ekalinin/Dockerfile.vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Raimondi/delimitMate'
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'gotcha/vimpdb', {'for': 'python'}
Plug 'fisadev/vim-isort', {'for': 'python'}
Plug 'lambdalisue/vim-pyenv', {'for': 'python'}
Plug 'tweekmonster/django-plus.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'jaxbot/github-issues.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-grepper'
Plug 'vim-utils/vim-man'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'SirVer/ultisnips',
Plug 'honza/vim-snippets'
Plug 'benekastah/neomake'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
Plug 'vimlab/split-term.vim'
Plug 'tpope/vim-repeat'
Plug 'reedes/vim-wordy'
Plug 'tpope/vim-sleuth'

call plug#end()

let mapleader=","
imap jk <Esc>

" colorschemes {
colorscheme gruvbox
set background=dark
" }

" options galore {
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
" }

" writing {
nnoremap <leader>Qa vapJgqap
nnoremap <leader>qa gqap
nnoremap <leader>zz 1z=
" }

" terminal mode {
if exists(':tnoremap')
  tnoremap jk <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  tnoremap jk <C-\><C-n>
  tnoremap <C-@> <C-\><C-n>:tab sp<cr>:startinsert<cr>
  let g:terminal_scrollback_buffer_size=100000
  augroup vimrc_term
    au!
    autocmd! BufEnter term://* startinsert
  augroup END
endif

nnoremap <Leader>py :sp \| :term py.test<cr>
nnoremap <Leader>px :sp \| :term py.test -x<cr>
nnoremap <Leader>pk :sp \| :term p -k
" }

" escape parens {
inoremap <C-e> <C-o>a
inoremap <C-d> <C-o>A
" }

" stylish-haskell {
nnoremap <leader>sh %!stylish-haskell<CR>
" }

" highlight characters past 79 chars  {
match ErrorMsg '\%>79v.\+'
" }

" edit/save $MYVIMRC conveniently {
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" }

" vim-plug {
nnoremap <leader>pi :PlugInstall <CR>
nnoremap <leader>pc :PlugClean <CR>
" }

" git gutter {
let g:gitgutter_max_signs=10000
let g:gitgutter_realtime=1
let g:gitgutter_eager=1
" }

" https://blog.mikecordell.com/vim/2014/07/20/quick-fixup-in-vim-with-fugitive.html {
nnoremap <silent> <leader>gl :Git! log<CR>ggw
nnoremap <leader>f yiw <ESC>:Git commit --fixup=<C-r>"<CR>
" }

" nerdtree {
map ,<C-n> :NERDTreeToggle<CR>
let g:nerdtree_tabs_autoclose=1
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_smart_startup_focus=2
let g:nerdtree_tabs_startup_cd=1

" http://www.mokacoding.com/blog/nerdtree-relative-numbers/
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
" }

" ctrl-p {
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
" }

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
let g:neomake_open_list=1
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

" disable auto commenting {
au FileType * setlocal formatoptions-=cro
" }

" jedi {
let g:jedi#usages_command=""
let g:jedi#popup_select_first=1
let g:jedi#use_tabs_not_buffers=1
let g:jedi#show_call_signatures="2"
let g:jedi#auto_close_doc=1
" }

" isort {
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

" close scratch window when getting into insert mode {
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
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

" elm.vim {
let g:elm_format_autosave=1
" }

" javascript.vim {
let g:javascript_enable_domhtmlcss=1
" }

" strip all that whitespace
autocmd BufWritePre * StripWhitespace

" python
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" github-issues
let g:gissues_lazy_load=1

" haskell indentation {
au FileType haskell setl tabstop=4 expandtab softtabstop=2 shiftwidth=2 shiftround
" }

" dictionary mappings {
nnoremap <Leader>dg :sp \| :term dict -d gcide<space>
nnoremap <Leader>dt :sp \| :term dict -d moby-thesaurus<space>
" }

" mutt (related to text_flowed)
setlocal fo+=aw
