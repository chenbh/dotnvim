local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- npm install -g vim-language-server
vim.lsp.config('vimls', {
  capabilities = capabilities,
})

