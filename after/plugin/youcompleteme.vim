" sensible shortcuts
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gD :YcmCompleter GoToDefinition<CR>
nnoremap gi :YcmCompleter GoToImplementation<CR>
nnoremap gy :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap gf :YcmCompleter FixIt<CR>
nnoremap gR :YcmCompleter RefactorRename

nnoremap yi :YcmShowDetailedDiagnostic<CR>
nnoremap yr :YcmRestartServer<CR>


" populate location list
let g:ycm_always_populate_location_list = 1

" load lsp
runtime ycm_lsp.vim
