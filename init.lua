-- Plugin management
--
local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('SmiteshP/nvim-navic')

Plug('sbdchd/neoformat')

Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')

Plug('jesseleite/vim-agriculture')
Plug('junegunn/fzf', {
  ['do'] = function()
    vim.fn['fzf#install']()
  end
})
Plug('junegunn/fzf.vim')

Plug('tpope/vim-vinegar')
Plug('tpope/vim-eunuch')
Plug('tpope/vim-commentary')
Plug('tpope/vim-fugitive')
Plug('AndrewRadev/linediff.vim')
Plug('tpope/vim-rhubarb')

Plug('morhetz/gruvbox')
Plug('airblade/vim-gitgutter')

Plug('maxmellon/vim-jsx-pretty')
Plug('hashivim/vim-terraform')
Plug('cappyzawa/starlark.vim')

vim.call('plug#end')

local navic = require("nvim-navic")


-- Configuration
-- use bash to execute stuff
vim.o.shell = '/bin/bash'

-- tab stuff
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.autoindent = true
vim.o.expandtab = true

-- show line numbers
vim.o.number = true

-- highlight trailing spaces
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = 'red', bg = 'red' })
local whitespace_group = vim.api.nvim_create_augroup('HighlightWhiteSpace', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = whitespace_group,
  callback = function()
    vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = 'red', bg = 'red' })
  end,
})
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'InsertLeave' }, {
  group = whitespace_group,
  callback = function()
    vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
  end,
})
vim.api.nvim_create_autocmd('InsertEnter', {
  group = whitespace_group,
  callback = function()
    vim.fn.matchadd('ExtraWhitespace', [[\s\+\%#\@<!$]])
  end,
})
vim.api.nvim_create_autocmd('BufWinLeave', {
  group = whitespace_group,
  callback = function()
    vim.fn.clearmatches()
  end,
})

-- status bar
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- Map <C-s> to save the file in insert mode and stay in insert mode

-- save on enter
vim.keymap.set('n', '<cr>', ':w<cr>', { noremap = true, silent = true })

-- exit buffer on shift+escape
vim.keymap.set('n', '<S-Esc>', ':q<cr>', { noremap = true, silent = true })

-- clear highlights on space
vim.keymap.set('n', '<space>', ':noh<cr>', { silent = true })

-- use "o" in addition to enter for quickfix/locationlist
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'o', '<cr>', { buffer = true })
  end,
})

-- shorthand for window switching
vim.keymap.set('n', '<C-S-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-S-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-S-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-S-l>', '<C-w>l', { noremap = true })

-- fast scrolling without moving cursor
vim.keymap.set('n', '<C-e>', '10<C-e>', { noremap = true })
vim.keymap.set('n', '<C-y>', '10<C-y>', { noremap = true })

-- fast scrolling with cursor
vim.keymap.set('n', '<C-j>', '10j', { noremap = true })
vim.keymap.set('n', '<C-k>', '10k', { noremap = true })

vim.keymap.set('v', '<C-j>', '10j', { noremap = true })
vim.keymap.set('v', '<C-k>', '10k', { noremap = true })

-- vim.keymap.set('i', '<C-j>', '<C-o>10j', {noremap = true})
-- vim.keymap.set('i', '<C-k>', '<C-o>10k', {noremap = true})

-- disable scratch preview window
vim.o.completeopt = 'menu,menuone,noselect'

-- enable mouse clicking and scrolling
vim.o.mouse = 'a'

-- open quickfix files in last used window
vim.o.switchbuf = 'uselast'

-- folds
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- close all toplevel folds
vim.keymap.set('n', 'zT', ':%foldc<cr>')
vim.keymap.set('n', 'zf', 'zA')

-- color schemes
vim.opt.termguicolors = true
vim.cmd.syntax('enable')
vim.g.gruvbox_contrast_dark = "dark"
vim.cmd.colorscheme('gruvbox')

-- terminal
vim.api.nvim_create_user_command('OpenTerm', function(opts)
  vim.cmd.vnew()
  if opts.args ~= '' then
    vim.cmd.term(opts.args)
  else
    vim.cmd.term()
  end
end, { nargs = '?' })
vim.keymap.set('n', '<c-t>', ':OpenTerm<cr>')
vim.keymap.set('t', '<S-Esc>', '<C-\\><C-n>')
vim.cmd.cnoreabbrev('!', 'OpenTerm')

-- increase maxmempattern to search in large files
vim.o.maxmempattern = 2000000

-- always use system clipboard for yanks
-- vim.o.clipboard:append('unnamedplus')

-- allow project-specific configs
vim.o.exrc = true




-- LSP
-- neovim/nvim-lspconfig Mappings.

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



-- Auto completion
-- hrsh7th/nvim-cmp Mappings.
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
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
  }, {
    { name = 'buffer' },
  })
})

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
