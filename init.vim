" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'sbdchd/neoformat'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'jesseleite/vim-agriculture'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/linediff.vim'

Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'

Plug 'maxmellon/vim-jsx-pretty'
Plug 'hashivim/vim-terraform'
Plug 'cappyzawa/starlark.vim'

call plug#end()


" use bash to execute stuff
set shell=/bin/bash

" tab stuff
set shiftwidth=2
set tabstop=2
set autoindent
set expandtab

" show line numbers
set number

" save on enter
nnoremap <expr> <cr> &modifiable?":w\<cr>":"\<cr>"

" exit buffer on shift+escape
nnoremap <S-Esc> :q<cr>

" clear highlights on space
nmap <space> :noh<cr>

" use "o" in additon to enter for quickfix/locationlist
autocmd FileType qf nmap <buffer> o <cr>

" highligh trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup HighlightWhiteSpace
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup end

" shorthand for window switching
nnoremap <C-S-h> <C-w>h
nnoremap <C-S-j> <C-w>j
nnoremap <C-S-k> <C-w>k
nnoremap <C-S-l> <C-w>l

" fast scrolling without moving cursor
nnoremap <C-e> 10<C-e>
nnoremap <C-y> 10<C-y>

" fast scrolling with cursor
nnoremap <C-j> 10j
nnoremap <C-k> 10k

vnoremap <C-j> 10j
vnoremap <C-k> 10k

inoremap <C-j> <C-o>10j
inoremap <C-k> <C-o>10k

" disable scratch preview window
set completeopt=menu,menuone,noselect

" enable mouse clicking and scrolling
set mouse=a

" open quickfix files in last used window
set switchbuf=uselast

" folds
set foldmethod=syntax
set foldlevel=999
" close all toplevel folds
nmap zT :%foldc<cr>

" color schemes
set termguicolors
syntax enable
let g:gruvbox_contrast_dark = "dark"
colorscheme gruvbox

" terminal
command -nargs=? OpenTerm vnew | term <args>
nnoremap <c-t> :OpenTerm<cr>
cnoreabbrev ! OpenTerm

" increase maxmempattern to search in large files
set mmp=2000000

" always use system clipboard for yanks
" set clipboard+=unnamedplus

lua require('lsp')
lua require('project_settings')
