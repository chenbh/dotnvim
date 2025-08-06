nnoremap <C-space> :FZF<cr>
nnoremap <S-space> :Rg<cr>

let $FZF_DEFAULT_COMMAND='rg --files'
" let $FZF_CTRL_T_COMMAND='rg --files'
"
let g:fzf_action = {
      \ 'ctrl-q': 'fill_quickfix' }


command! -bang -nargs=* Rg2
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)
