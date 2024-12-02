local M = {}

M.options = {
  theme = 'onedark',
  disabled_filetypes = {
    statusline = {
      'neo-tree',
    },
  }
}
--  component_separators = { left = '', right = ''},
--    section_separators = { left = '', right = ''},
M.sections = {
  lualine_b = {
    { "branch" },
    {
      "diagnostics",
      symbols = {
        error = G_ICON.diagnostics.Error,
        warn = G_ICON.diagnostics.Warn,
        info = G_ICON.diagnostics.Info,
        hint = G_ICON.diagnostics.Hint,
      },
    }
  },
  lualine_c = {
    function()
      local root = require("util.root")
      local cwd = root.cwd()
      local path = vim.fn.expand("%:p") or ""
      return path:sub(#cwd + 2)
    end
  }
}

M.inactive_sections = {
  lualine_a = {
    function()
      return "󰒲'"
    end
  },
  lualine_b = {'filename'},
  lualine_c = {},
  lualine_x = {},
}

return M
