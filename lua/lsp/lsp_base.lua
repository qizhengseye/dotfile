local M = {}
local D = vim.diagnostic
local svrty = D.severity

M.diagnostic = {
  virtual_text = false,
  signs = {
      text = {
      [svrty.INFO] = G_ICON.diagnostics.Information,
      [svrty.WARN] = G_ICON.diagnostics.Warning,
      [svrty.ERROR] = G_ICON.diagnostics.Error,
    },
  },
  severity_sort = true,
}

D.config(M.diagnostic)
