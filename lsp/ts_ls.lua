local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- npm install -g typescript-language-server
vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  settings = {
    typescript = { format = { semicolons = 'insert' } },
  },
})
