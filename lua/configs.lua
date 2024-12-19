local M = {}
M.lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
M.ideal_width = 55
M.popup = {
  style = "rounded",
}

M.required_lsp = {
  lua_ls = {'lua'},
  clangd = {'c', 'cpp'}
}

return M
