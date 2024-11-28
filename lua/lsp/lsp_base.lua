local M = {}
local D = vim.diagnostic
local svrty = D.severity

M.diagnostic = {
  virtual_text = false,
  signs = {
    text = {
      [svrty.INFO] = g_icon.diagnostics.Information,
      [svrty.WARN] = g_icon.diagnostics.Warning,
      [svrty.ERROR] = g_icon.diagnostics.Error,
    },
  },
  severity_sort = true,
}

D.config(M.diagnostic)
