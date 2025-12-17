local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- npm install -g bash-language-server
vim.lsp.config('bashls', {
  capabilities = capabilities,
})
