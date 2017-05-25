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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rhubarb'

" Navigation
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'

" Linting
Plug 'neomake/neomake'

" NVim Enhancements
Plug 'vimlab/split-term.vim'
Plug 'rafi/vim-tinyline'
Plug 'ervandew/supertab'
Plug 'tpope/vim-unimpaired'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'

" Writing
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'

" Syntax highlighting
Plug 'ekalinin/Dockerfile.vim'
Plug 'chase/vim-ansible-yaml'

" FIXME: Sort out
" AndrewRadev/linediff.vim

call plug#end()

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

au BufReadPost * nested call MyFollowSymlink(expand('%'))
au FileType python let b:delimitMate_nesting_quotes=['"', '`']
au FileType nerdtree setlocal relativenumber
au FileType qf set wrap

autocmd! BufWritePre  * StripWhitespace
autocmd! BufWritePost *.hs InteroReload
autocmd! BufWritePost *.py Isort
autocmd! BufWritePost * Neomake

imap jk <Esc>

ino <C-e> <C-o>a
ino <C-d> <C-o>A
ino <C-t> <Esc>:tabnew<cr>

nn <Leader>Z 1z=
nn <Leader>ev :split $MYVIMRC<cr>
nn <Leader>sv :source $MYVIMRC<cr>
nn <Leader>pi :PlugInstall<cr>
nn <Leader>pu :PlugUpdate<cr>
nn <Leader>pg :PlugUpgrade<cr>
nn <Leader>pc :PlugClean<cr>
nn <Leader>cf :CtrlPFunky<cr>
nn <Leader>ct :CtrlPTag<cr>
nn <Leader>qc :lclose<cr>
nn <Leader>qo :lopen<cr>
nn <C-t> :tabnew<cr>
nn <space> <Plug>(easymotion-s)
nn <Leader><C-n> :NERDTreeToggle<cr>
nn <C-j> <C-w>j
nn <C-k> <C-w>k
nn <C-l> <C-w>l
nn <C-h> <C-w>h
nn <Leader>hio :InteroOpen<cr>
nn <Leader>hik :InteroKill<cr>
nn <Leader>hic :InteroHide<cr>
nn <Leader>hil :InteroLoadCurrentModule<cr>
nn <Leader>hie :InteroEval<cr>
nn <Leader>hit :InteroGenericType<cr>
nn <Leader>hiT :InteroType<cr>
nn <Leader>hii :InteroInfo<cr>
nn <Leader>hiI :InteroTypeInsert<cr>
nn <Leader>hid :InteroGoToDef<cr>
nn <Leader>hiu :InteroUses<cr>
nn <Leader>pp :10Term ipython --profile=lwm<cr>
nn <Leader>gd :Git diff<cr>

tno <C-h> <C-\><C-n><C-w>h
tno <C-j> <C-\><C-n><C-w>j
tno <C-k> <C-\><C-n><C-w>k
tno <C-l> <C-\><C-n><C-w>l
tno jk <C-\><C-n>

augroup vimrc_term
  au!
  autocmd! BufEnter term://* startinsert
augroup END

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
set nosmartindent
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

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
