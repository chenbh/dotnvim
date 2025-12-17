local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- go install golang.org/x/tools/gopls@latest
vim.lsp.config('gopls', {
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = { unusedparams = true, shadow = true },
      staticcheck = true,
      usePlaceholders = true,
      -- hints = {
      --   compositeLiteralFields = true,
      --   constantValues = true,
      --   functionTypeParameters = true,
      --   parameterNames = true,
      --   rangeVariableTypes = true,
      -- },
    },
  },
})
