
call plug#begin('~/.vim/plugged')
" Plug 'chrisbra/csv.vim'                                         " Csv filetype
" Plug 'christoomey/vim-tmux-navigator'                             " Seamless Tmux navigation
" Plug 'morhetz/gruvbox'
" Plug 'vimwiki/vimwiki'
" Plug 'zchee/deoplete-go'
" Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'vim-pandoc/vim-rmarkdown'
" Plug 'markonm/traces.vim'
" Plug 'benekastah/neomake'                                         " Linter/maker
" Plug 'davinche/godown-vim'
" Plug 'jiangmiao/auto-pairs'                                     " Auto-close brackets
" Plug 'rakr/vim-one'                         " Colorscheme
" Plug 'reewr/vim-monokai-phoenix'                                " Colortheme
" Plug 'edkolev/tmuxline.vim'
" Plug 'tclem/vim-arduino'
" Plug 'vim-latex/vim-latex'
" Plug 'lukaszkorecki/workflowish'

" Latex
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'dracula/vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }            " Latex preview Plug

" Colorschemes
" Plug 'jeffkreeftmeijer/vim-dim'
" Plug 'noahfrederick/vim-noctu'
" Plug 'evgenyzinoviev/vim-vendetta'
" Plug 'chriskempson/base16-vim'                                    " Base16 colorschemes
" Plug 'mhartington/oceanic-next'
" Plug 'kristijanhusak/vim-hybrid-material'
" Plug 'liuchengxu/space-vim-theme'
Plug 'rakr/vim-one'

" Other appeareance
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'                                        " Lean & mean status/tabline
Plug 'lilydjwg/colorizer'                                       " Colorize color definitions
Plug 'ap/vim-buftabline'                                        " Forget Vim tabs, now you can have buffer tabs
Plug 'timakro/vim-searchant'                                    " Better highlighting of search

" Syntax and language specific
" TODO try out: sheerun/vim-polyglot " can replace python, i3, hastkell, vim-go
Plug 'OrangeT/vim-csharp', {'for': 'cs'}                        " Csharp syntax
Plug 'PotatoesMaster/i3-vim-syntax', {'for': 'i3'}              " I3-config syntax
Plug 'hdima/python-syntax', {'for': 'python'}
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
Plug 'jeroenbourgois/vim-actionscript', {'for': 'actionscript'} " Actionscript syntax
Plug 'fatih/vim-go'
Plug 'buoto/gotests-vim'                         " Generate test for Go function in current line
Plug 'justinmk/vim-syntax-extra'
Plug 'stevearc/vim-arduino'
Plug 'pearofducks/ansible-vim'

" Completion and snippets
"TODO Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}       " Autocompletion
"TODO Plug 'zchee/deoplete-clang'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
"TODO Plug 'SirVer/ultisnips'                                           " Snippet engine
Plug 'honza/vim-snippets'                                         " Snippets
Plug 'w0rp/ale'

" Git
Plug 'airblade/vim-gitgutter'                                     " Shows a git diff in the gutter
Plug 'rhysd/committia.vim'                                        " Better commit message editor

" Markup
Plug 'godlygeek/tabular'                                          " The tabular plugin must come before vim-markdown
Plug 'plasticboy/vim-markdown'
Plug 'shime/vim-livedown'
Plug 'dhruvasagar/vim-table-mode', {'on': 'TableModeToggle'}      " Easy ascii tables

" Tags
Plug 'ludovicchabant/vim-gutentags'                               " Autognerate Tags
Plug 'majutsushi/tagbar'

" Vim text-objects
Plug 'michaeljsmith/vim-indent-object'                            " Indention based Textobject (dai, cai...)
Plug 'tpope/vim-surround'                                         " Surround text-object

" Whitespace
Plug 'junegunn/vim-easy-align'
Plug 'ntpeters/vim-better-whitespace'                             " Hightlight all trailing whitespace in red
Plug 'vim-scripts/Align'                                          " Dependency for sqlformatter

" Other helpers
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy find everything
Plug 'junegunn/fzf.vim'
Plug 'jamessan/vim-gnupg', {'for': 'gpg'}                         " Edit ggp-encrypted files
Plug 'AndrewRadev/switch.vim'                                     " Switch segments of text with predefined replacements
Plug 'Chiel92/vim-autoformat'                                     " Autoformat files integrating existing code formatters
Plug 'vim-scripts/BufOnly.vim'                                    " Close all buffers except the current
Plug 'tpope/vim-commentary'                                       " Commenter
Plug 'tpope/vim-eunuch'                                           " Usefull shell comamnds as vim commands e.g. :SudoWrite
Plug 'tpope/vim-repeat'                                           " Repeat with dot for more actions
Plug 'tpope/vim-vinegar'                                          " Enhance netrw file browser
Plug 'triglav/vim-visual-increment'                               " Visually increment numbers
Plug 'rhysd/vim-grammarous'                                       " Grammar checking with languagetool

call plug#end()

" Plugin options

" Arduino
let g:arduino_programmer = 'arduino:avrispmkii'                   " arduino programmer
let g:arduino_dir = '/usr/share/arduino'
let g:arduino_args = '--verbose-upload'

" Markdown
let g:livedown_browser = "firefox"                                " the browser to use for preview

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"

" Deoplete
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
" let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
" call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
" if !exists('g:deoplete#omni_patterns')
" 	let g:deoplete#omni_patterns = {}
" endif
" let g:deoplete#omni_patterns.tex =
" 			\ '\v\\%('
" 			\ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
" 			\ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
" 			\ . '|hyperref\s*\[[^]]*'
" 			\ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
" 			\ . '|%(include%(only)?|input)\s*\{[^}]*'
" 			\ . ')\m'

" Taskwarrior
let g:task_default_prompt = [ 'project',  'description', 'due']

" Ale
" let g:ale_linters ={
" \   'haskell': ['hlint', 'hdevtools', 'hfmt'],
" \}
let g:ale_sign_column_always = 1    "Keep the sign gutter open

" Neomake
" autocmd! BufWritePost * Neomake " run neomake on file save
" call neomake#configure#automake('nrwi', 500)
" Default file type for .tex files

" Fzf, show file preview
let g:fzf_files_options = '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" Switch
let g:switch_custom_definitions =
			\ [
			\   ['foo', 'bar', 'baz'],
			\   [ 'on', 'off'],
			\   ['_', '#'],
			\   ['LOW', 'HIGH']
			\ ]
