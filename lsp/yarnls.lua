local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- yarn global add yaml-language-server
vim.lsp.config('yamlls', {
  capabilities = capabilities,
  settings = {
    yaml = {
      keyOrdering = false,
      schemaStore = {
        enable = false,
      }
    }
  }
})

vim.lsp.enable('yamlls')
