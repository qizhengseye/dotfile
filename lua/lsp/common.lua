local M = {}
local D = vim.diagnostic
local svrty = D.severity

M.diagnostic = {
  virtual_text = false,
  signs = {
      text = {
      [svrty.INFO] = G_ICON.dg.Information,
      [svrty.WARN] = G_ICON.dg.Warning,
      [svrty.ERROR] = G_ICON.dg.Error,
    },
  },
  severity_sort = true,
}

D.config(M.diagnostic)

--for keymaps

vim.api.nvim_create_autocmd(
  {'LspAttach'},
  {
    callback = function(args)
--      vim.keymap.set("n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {})
--      vim.keymap.set("n", "gD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", {})
--      vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').close_all_win()<CR>", {})
--      vim.keymap.set("n", "gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {})
      vim.keymap.set("n", "K", vim.lsp.buf.hover(), {})
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename(), {})
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {})
    end
  }
)
