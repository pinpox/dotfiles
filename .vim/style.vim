
set listchars=tab:\|\ ,trail:·,nbsp:· " Display extra whitespace, show tabs as bar (indent-guides)
set list

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


if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
syntax on
colorscheme onedark


