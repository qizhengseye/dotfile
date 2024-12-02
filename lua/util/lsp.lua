local U = {}

U.has_clients = function(buf)
  local nxt = next
  local clients = vim.lsp.get_clients({bufnr=buf})
  return nxt(clients) ~= nil
end

return U
