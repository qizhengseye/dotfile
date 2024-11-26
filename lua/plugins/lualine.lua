return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function(_, _)
      local opts = require "editor.lualine"
      require('lualine').setup(opts)
    end
}
