-- Project local settings for LS


local group = vim.api.nvim_create_augroup("local_lsp_settings", {})

-- helper for loading custom LSP settings based on project path
local lsp_load_settings = function(lsp_name, pattern, new_settings)
  vim.api.nvim_create_autocmd("LspAttach", {
    pattern = pattern,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.name ~= lsp_name then return end

      local merged_settings = client.config.settings
      for k,v in pairs(new_settings) do merged_settings[k] = v end

      client.notify("workspace/didChangeConfiguration", {settings = settings})
    end,
    group = group,
    desc = string.format('Add custom %s settings when in %s', lsp_name, pattern),
    once = true,
  })
end

-- e.g.:
--
-- lsp_load_settings("gopls", "*/workspace/example/*", {
--   gopls = {
--     buildFlags = {"-tags", "foo"},
--   },
-- })
