nnoremap <C-space> :FZF<cr>
nnoremap <S-space> :Rg<cr>

let $FZF_DEFAULT_COMMAND='rg --files'
" let $FZF_CTRL_T_COMMAND='rg --files'
"
let g:fzf_action = {
      \ 'ctrl-q': 'fill_quickfix' }
