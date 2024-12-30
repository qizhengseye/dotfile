vim.cmd("autocmd FileType norg setlocal shiftwidth=2 softtabstop=2 wrap conceallevel=2")
vim.api.nvim_create_user_command("goconf", ":e $MYVIMRC | :cd %:p:h", {})

local M = {}
M.lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
M.ideal_width = 55
M.cmp_item_cnt = vim.o.lines > 60 and 20 or (vim.o.lines < 30 and 10 or math.floor(vim.o.lines / 3))
M.popup = {
  style = "rounded",
}

M.required_lsp = {
  lua_ls = {'lua'},
  clangd = {'c', 'cpp'}
}

return M
