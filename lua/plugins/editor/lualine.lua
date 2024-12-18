return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'onedark',
      disabled_filetypes = {
        statusline = {
          'neo-tree',
        },
      },
      sections = {
        lualine_b = {
          { "branch" },
          {
            "diagnostics",
            symbols = {
              error = G_ICON.dg.Error,
              warn = G_ICON.dg.Warn,
              info = G_ICON.dg.Info,
              hint = G_ICON.dg.Hint,
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
    },
    config = function(_, opt)
      require('lualine').setup(opt)
    end
}
