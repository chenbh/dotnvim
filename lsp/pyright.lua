local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- npm install -g pyright
vim.lsp.config('pyright', {
  capabilities = capabilities
})
