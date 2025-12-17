-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('clangd', {
  capabilities = capabilities
})
