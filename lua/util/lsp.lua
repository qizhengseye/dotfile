local U = {}
local i = 0
i = i + 1

U.has_clients = function(buf)
  local nxt = next
  local clients = vim.lsp.get_clients({bufnr=buf})
  return nxt(clients) ~= nil
end

U.setup_lsp_client = function(ft, lsp, config)
  vim.api.nvim_create_autocmd(
    {'FileType'},
    {
      pattern = ft,
      callback = function(args)
        if not config.lsp_inited then
          config.lsp_inited = true
          require'lspconfig'[lsp].setup(config)
          require'lspconfig'[lsp].launch()
        end
      end
    }
  )
end

return U
