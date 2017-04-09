function! MyFollowSymlink(...)
  if exists('w:no_resolve_symlink') && w:no_resolve_symlink
    return
  endif
  if &ft == 'help'
    return
  endif
  let fname=a:0 ? a:1 : expand('%')
  if fname =~ '^\w\+:/'
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
Plug 'tomasr/molokai'

Plug 'mpickering/hlint-refactor-vim', {'for': 'haskell'}
Plug 'nbouscal/vim-stylish-haskell', {'for': 'haskell'}
Plug 'parsonsmatt/intero-neovim', {'for': 'haskell'}

Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'fisadev/vim-isort', {'for': 'python'}
Plug 'lambdalisue/vim-pyenv', {'for': 'python'}

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'junegunn/gv.vim'

Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'

Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim'
Plug 'neomake/neomake'
Plug 'rafi/vim-tinyline'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'tpope/vim-unimpaired'
Plug 'ntpeters/vim-better-whitespace'

Plug 'ekalinin/Dockerfile.vim'
Plug 'chase/vim-ansible-yaml'

Plug 'takac/vim-hardtime'

call plug#end()

let mapleader=","

imap jk <Esc>
tnoremap jk <C-\><C-n>

set background=dark
colorscheme gruvbox

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

nnoremap <leader>qa gqap
nnoremap <leader>Z 1z=

inoremap <C-e> <C-o>a
inoremap <C-d> <C-o>A

nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>pi :PlugInstall <CR>
nnoremap <leader>pc :PlugClean <CR>

ret g:gitgutter_max_signs=10000
let g:gitgutter_realtime=1
let g:gitgutter_eager=1

map ,<C-n> :NERDTreeToggle<CR>
let g:nerdtree_tabs_autoclose=1
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_smart_startup_focus=2
let g:nerdtree_tabs_startup_cd=1

let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

nnoremap <Leader>cf :CtrlPFunky<Cr>
nnoremap <leader>ct :CtrlPTag<cr>

let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
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

let g:deoplete#enable_at_startup=1
let g:deoplete#enable_ignore_case=1
let g:deoplete#enable_smart_case=1

let g:neomake_python_enabled_makers=['pylama']
let g:neomake_haskell_enabled_makers=['hlint']
let g:neomake_open_list=2
let g:neomake_list_height=6
let g:neomake_verbose=1
let g:neomake_logfile='/tmp/neomake.log'

nnoremap <leader>qc :lclose<CR>
nnoremap <leader>qo :lopen<CR>

let g:SuperTabDefaultCompletionType="<c-n>"
let g:SuperTabLongestHighlight=1

au FileType python let b:delimitMate_nesting_quotes=['"', "`"]

let g:jedi#usages_command=""
let g:jedi#popup_select_first=1
let g:jedi#use_tabs_not_buffers=1
let g:jedi#show_call_signatures="2"
let g:jedi#auto_close_doc=1

let g:vim_isort_map='<C-i>'

nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-k>"

nmap <space> <Plug>(easymotion-s)

let g:EasyMotion_smartcase=1
let g:EasyMotion_use_upper=1

hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First MatchParen
hi link EasyMotionTarget2Second MatchParen
hi link EasyMotionMoveHL Search

autocmd! BufWritePre  *    StripWhitespace
autocmd! BufWritePost *.hs InteroReload
autocmd! BufWritePost *    Neomake

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

nnoremap <Leader>dg :sp \| :term dict -d gcide<space>
nnoremap <Leader>dt :sp \| :term dict -d moby-thesaurus<space>
nnoremap <Leader>p :sp \| :term python<cr>
nnoremap <Leader>t :sp \| :term<cr>

let g:ansible_options={'ignore_blank_lines': 0}

au FileType qf set wrap

nnoremap <Leader>hio :InteroOpen<CR>
nnoremap <Leader>hik :InteroKill<CR>
nnoremap <Leader>hic :InteroHide<CR>
nnoremap <Leader>hil :InteroLoadCurrentModule<CR>
nnoremap <Leader>hie :InteroEval<CR>
nnoremap <Leader>hit :InteroGenericType<CR>
nnoremap <Leader>hiT :InteroType<CR>
nnoremap <Leader>hii :InteroInfo<CR>
nnoremap <Leader>hiI :InteroTypeInsert<CR>
nnoremap <Leader>hid :InteroGoToDef<CR>
nnoremap <Leader>hiu :InteroUses<CR>

let g:hardtime_default_on = 0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
