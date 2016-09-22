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

" colorschemes
Plug 'morhetz/gruvbox'

" haskell

" Can't use while hacking on `commercialhaskell/stack`
" It's just too slow ...
" Plug 'eagletmt/neco-ghc', {'for': 'haskell'}

Plug 'itchyny/vim-haskell-indent', {'for': 'haskell'}
Plug 'jaspervdj/stylish-haskell', {'for': 'haskell'}
Plug 'mpickering/hlint-refactor-vim', {'for': 'haskell'}

" elm
Plug 'lambdatoast/elm.vim', {'for': 'elm'}

" docker
Plug 'ekalinin/Dockerfile.vim'

" javascript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

" programming
Plug 'Raimondi/delimitMate'
Plug 'janko-m/vim-test'
Plug 'Yggdroot/indentLine'

" python
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'gotcha/vimpdb', {'for': 'python'}
Plug 'fisadev/vim-isort', {'for': 'python'}

" django
Plug 'tweekmonster/django-plus.vim'

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
Plug 'mhinz/vim-startify'

" motion
Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'

" gnu/linux utils
Plug 'vim-utils/vim-man'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" github
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'

" completions
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'SirVer/ultisnips',
Plug 'honza/vim-snippets'

" static analysis
Plug 'benekastah/neomake'

" manipulation
Plug 'tpope/vim-commentary'

" quickfix
Plug 'tpope/vim-unimpaired'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

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
set spell
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
" }

" terminal mode mappings {
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
" let g:gitgutter_highlight_lines=1
" }

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

" nerdtree {
map ,<C-n> :NERDTreeToggle<CR>
let g:nerdtree_tabs_autoclose=1
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_smart_startup_focus=2
let g:nerdtree_tabs_startup_cd=1
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
let g:neomake_python_enabled_makers=['pylama']

" It would be great to use `hdevtools` but so far, it doesn't
" have great integration with stack. Relying on only hlint for now.
" https://github.com/hdevtools/hdevtools/issues/37
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
au FileType python let b:delimitMate_nesting_quotes=['"']
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

" gist {
nnoremap <leader>gl :Gist -l<CR>
" }

" ultisnip {
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-k>"
" }

" escape parens {
inoremap <C-e> <C-o>a
inoremap <C-d> <C-o>A
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

" neco-ghc {

" https://github.com/eagletmt/neco-ghc#gnecoghc_enable_detailed_browse
" boot times are crazy for hacking on stack. Setting to 0 for now ...
let g:necoghc_enable_detailed_browse=0

let g:haskellmode_completion_ghc=0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" }

" vim-test {
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let g:test#python#runner='pytest'
let test#strategy="neovim"
" }

" elm.vim {
let g:elm_format_autosave=1
" }

" javascript.vim {
let g:javascript_enable_domhtmlcss=1
" }

" Makefile {
autocmd FileType make setlocal tabstop=2 noexpandtab
" }

" strip all that whitespace
autocmd BufWritePre * StripWhitespace

" indentline {
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '┆'
" }
