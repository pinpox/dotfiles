" PLUGINS:
"
call plug#begin('~/.vim/plugged')
source ~/.vim/plugins.vim
call plug#end()

" GENERAL OPTIONS:
"
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

" MISC:
"
let g:go_auto_type_info = 1 "Show Go type info of variables
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null "autoindent xml correctly

au BufRead,BufNewFile *.md setlocal textwidth=80 " Wrap markdown files to 80 chars per line

let g:ale_sign_column_always = 1    "Keep the sign gutter open
let g:airline#extensions#ale#enabled = 1
" autocmd! BufWritePost * Neomake " run neomake on file save
" call neomake#configure#automake('nrwi', 500)

autocmd Filetype rmd map <F8> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

" Default file type for .tex files
let g:tex_flavor = "latex"

" Cursor to last know position
if has("autocmd")
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif
endif

set listchars=tab:\|\ ,trail:·,nbsp:· " Display extra whitespace, show tabs as bar (indent-guides)
set list

" FILE BROWSING:
"
let g:netrw_banner=0                           " disable annoying banner
let g:netrw_browse_split=4                     " open in prior window
let g:netrw_altv=1                             " open splits to the right
let g:netrw_liststyle=3                        " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" KEY MAPPINGS:
"
source ~/.vim/mappings.vim

"PLUGIN OPTIONS:
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:deoplete#enable_at_startup = 1		" Use deoplete.
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
let g:arduino_programmer = 'arduino:avrispmkii'                 " arduino programmer
let g:arduino_dir = '/usr/share/arduino'
let g:arduino_args = '--verbose-upload'
let g:livedown_browser = "chromium"                             " the browser to use for preview
let g:task_default_prompt = [ 'project',  'description', 'due'] " Taskwarrior default fields

" indent lines and reselect visual group
vnoremap < <gv
vnoremap > >gv

" move lines up and down
vnoremap <C-k> :m-2<CR>gv
vnoremap <C-j> :m '>+<CR>gv

" Switch substitutions
source ~/.vim/switch_subs.vim

" Show file preview in fzf
let g:fzf_files_options = '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" APPEARANCE:
"
" hi Normal ctermfg=252 ctermbg=none
" let base16colorspace=256
colorscheme noctu

set background=dark " for the dark version
let g:airline_powerline_fonts = 0            " Powerline Symbols in bar
let g:airline_theme='base16'
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1          " changfe cursor depending on mode
set conceallevel=0
" Make comments italic
highlight Comment cterm=italic


if !exists('g:deoplete#omni_patterns')
    let g:deoplete#omni_patterns = {}
endif
let g:deoplete#omni_patterns.tex =
            \ '\v\\%('
            \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
            \ . '|hyperref\s*\[[^]]*'
            \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|%(include%(only)?|input)\s*\{[^}]*'
            \ . ')\m'


