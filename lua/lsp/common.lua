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
