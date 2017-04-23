call plug#begin('~/.config/nvim/plugged')

" Colorschemes
Plug 'morhetz/gruvbox'

" Haskell
Plug 'mpickering/hlint-refactor-vim', {'for': 'haskell'}
Plug 'nbouscal/vim-stylish-haskell', {'for': 'haskell'}
Plug 'parsonsmatt/intero-neovim', {'for': 'haskell'}

" Python
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'fisadev/vim-isort', {'for': 'python'}
Plug 'lambdalisue/vim-pyenv', {'for': 'python'}

" Auto-complete
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'junegunn/gv.vim'

" Navigation
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'

" Linting
Plug 'neomake/neomake'

" This is great but sometimes too slow
" Plug 'dojoteef/neomake-autolint'

" NVim Enhancements
Plug 'vimlab/split-term.vim'
Plug 'rafi/vim-tinyline'
Plug 'ervandew/supertab'
Plug 'tpope/vim-unimpaired'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Raimondi/delimitMate'

" Writing
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'

" Syntax highlighting
Plug 'ekalinin/Dockerfile.vim'
Plug 'chase/vim-ansible-yaml'

call plug#end()

set background=dark
colorscheme gruvbox

au BufReadPost * nested call MyFollowSymlink(expand('%'))
au FileType python let b:delimitMate_nesting_quotes=['"', '`']
au FileType nerdtree setlocal relativenumber
au FileType qf set wrap

autocmd! BufWritePre  * StripWhitespace
autocmd! BufWritePost *.hs InteroReload
autocmd! BufWritePost *.py Isort

imap jk <Esc>

ino <C-e> <C-o>a
ino <C-d> <C-o>A
ino <C-t> <Esc>:tabnew<cr>

nmap <leader>Z 1z=
nmap <leader>ev :split $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>
nmap <leader>pi :PlugInstall<cr>
nmap <leader>pu :PlugUpdate<cr>
nmap <leader>pg :PlugUpgrade<cr>
nmap <leader>pc :PlugClean<cr>
nmap <Leader>cf :CtrlPFunky<cr>
nmap <leader>ct :CtrlPTag<cr>
nmap <leader>qc :lclose<cr>
nmap <leader>qo :lopen<cr>
nmap <C-t> :tabnew<cr>
nmap <space> <Plug>(easymotion-s)
nmap <Leader><C-n> :NERDTreeToggle<cr>
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <Leader>hio :InteroOpen<cr>
nmap <Leader>hik :InteroKill<cr>
nmap <Leader>hic :InteroHide<cr>
nmap <Leader>hil :InteroLoadCurrentModule<cr>
nmap <Leader>hie :InteroEval<cr>
nmap <Leader>hit :InteroGenericType<cr>
nmap <Leader>hiT :InteroType<cr>
nmap <Leader>hii :InteroInfo<cr>
nmap <Leader>hiI :InteroTypeInsert<cr>
nmap <Leader>hid :InteroGoToDef<cr>
nmap <Leader>hiu :InteroUses<cr>
nmap <Leader>pp :10Term ipython --profile=lwm<cr>

tno <C-h> <C-\><C-n><C-w>h
tno <C-j> <C-\><C-n><C-w>j
tno <C-k> <C-\><C-n><C-w>k
tno <C-l> <C-\><C-n><C-w>l
tno jk <C-\><C-n>

augroup vimrc_term
  au!
  autocmd! BufEnter term://* startinsert
augroup END

let mapleader=","
let g:gitgutter_max_signs=10000
let g:gitgutter_realtime=1
let g:gitgutter_eager=1
let g:nerdtree_tabs_autoclose=1
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_smart_startup_focus=2
let g:nerdtree_tabs_startup_cd=1
let g:NERDTreeShowLineNumbers=1
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
let g:neomake_markdown_enabled_makers=['proselint']
let g:neomake_open_list=2
let g:neomake_list_height=6
let g:neomake_verbose=1
let g:neomake_logfile='/tmp/neomake.log'
let g:SuperTabDefaultCompletionType="<c-n>"
let g:SuperTabLongestHighlight=1
let g:jedi#usages_command=""
let g:jedi#popup_select_first=1
let g:jedi#use_tabs_not_buffers=1
let g:jedi#show_call_signatures="2"
let g:jedi#auto_close_doc=1
let g:vim_isort_map='<C-i>'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-k>"
let g:EasyMotion_smartcase=1
let g:EasyMotion_use_upper=1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
let g:ansible_options={'ignore_blank_lines': 0}
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:terminal_scrollback_buffer_size=100000

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
set splitbelow
set splitright

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
