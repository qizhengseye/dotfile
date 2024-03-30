local icon = require("common.icon")
local M = {

  theme = 'material',
  sections = {
    lualine_a = {
      {
        'mode',
      },
      {
        function()
          if require("utils").is_win_mode() then
            return ""
          else
            return ""
          end
        end,
      }
    },
    lualine_b = {
      { "branch" },
      {
        "diagnostics",
        symbols = {
          error = icon.diagnostics.Error,
          warn = icon.diagnostics.Warn,
          info = icon.diagnostics.Info,
          hint = icon.diagnostics.Hint,
        },
      }
    },
    lualine_c = {
      function()
        local root = require("utils.root")
        local cwd = root.cwd()
        local path = vim.fn.expand("%:p") or ""

        return path:sub(#cwd + 2)
      end
    }
  }
}
return M
