local M = {}
M.popup = {
  style = "rounded",
}

M.required_lsp = {
  lua_ls = {'lua'},
  clangd = {'c', 'cpp'}
}

return M
