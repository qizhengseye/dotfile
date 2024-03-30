return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",

    config = function(_, opts)
        require('lualine').setup(require("custom.ui.lualine"))
    end
}
