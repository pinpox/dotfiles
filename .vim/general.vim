filetype plugin indent on
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set hidden                     " Buffer becomes hidden when it is abandoned but is not unloaded
set autochdir                  " Automatically change the working dir to the one of the file
set autoindent                 " always set autoindenting on
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set clipboard=unnamedplus      " Set Clipboard to system's clipboard
set cursorline                 " highlight current line
set directory=~/.vimtmp        " Dir for temp files
set foldlevelstart=20          " start with open folds
set foldmethod=syntax          " set folding based on syntax
set history=50                 " keep 50 lines of command line history
set hlsearch                   " highlight matches
set ignorecase                 " Case insensitive search
set incsearch                  " search as characters are entered
set laststatus=2               " Always show the status line
set lazyredraw                 " redraw only when we need to.
set nobackup                   " dont create backups
set noswapfile                 " dont create a swapfile
set relativenumber             " show relative line numbers
set number                     " show absolute line numbers
set ruler                      " show the cursor position all the time
set scrolloff=5                " show lines above and below when scrolling
set showcmd                    " display incomplete commands
set smartcase                  " Case sensitive then capital is typed
set synmaxcol=200              " Maximum length of syntax highlighting
set tabstop=4                  " A tab is displayed 4 collumns wide
set softtabstop=4              " Size of a tab
set shiftwidth=4               " Size of a tab
set noexpandtab                " Don't expand tabs to spaces
set undodir=~/.vimtmp          " Dir for undofiles, same dir as the tempdir
set wildmenu                   " Complete commands
set wrapscan                   " Wrap when searching to beginning
set path+=**                   " Search down into subfolders, provides tab-completion for all file-related tasks
syntax enable                  " enable syntax highlighting



" let g:go_auto_type_info = 1 "Show Go type info of variables
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null "autoindent xml correctly
au BufRead,BufNewFile *.md setlocal textwidth=80 " Wrap markdown files to 80 chars per line
let g:ale_sign_column_always = 1    "Keep the sign gutter open
let g:airline#extensions#ale#enabled = 1
" autocmd! BufWritePost * Neomake " run neomake on file save
" call neomake#configure#automake('nrwi', 500)
" Default file type for .tex files
let g:tex_flavor = "latex"

" Cursor to last know position
if has("autocmd")
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif
endif
