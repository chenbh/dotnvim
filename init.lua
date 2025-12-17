-- Too lazy to port init.vim to lua
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

local navic = require("nvim-navic")

-- neovim/nvim-lspconfig Mappings.
--
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'ee', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'eN', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
vim.keymap.set('n', 'en', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
vim.keymap.set('n', 'el', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', 'eq', vim.diagnostic.setqflist, opts)

-- Use an autocmd function to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gS', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

    -- Format on save
    local format_group = vim.api.nvim_create_augroup("LspFormatting_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
      end,
    })

    -- Organize imports on save
    if type(client.server_capabilities.codeActionProvider) == "table" and
        vim.tbl_contains(client.server_capabilities.codeActionProvider.codeActionKinds, "source.organizeImports") then
      local organize_group = vim.api.nvim_create_augroup("LspOrganizeImports_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = organize_group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" }, diagnostics = {} },
            apply = true,
          })
        end,
      })
    end

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end

    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
      vim.keymap.set('n', 'gl', vim.lsp.buf.document_symbol, bufopts)
    end
  end
})


-- hrsh7th/nvim-cmp Mappings.
--
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<tab>'] = cmp.mapping.select_next_item(),
    ['<S-tab>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
for _, v in pairs({ '/', '?' }) do
  cmp.setup.cmdline(v, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
end

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- LSP servers

vim.lsp.enable({ 'vimls', 'gopls', 'bashls', 'yamlls', 'lua_ls' })

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
