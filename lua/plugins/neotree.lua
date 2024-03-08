return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
      {"<leader>e", ":Neotree reveal toggle left<cr>"}
    },
    opts = {},

    config = function(_, _)
        local cfg = require("custom.fs.neotree")
        require("neo-tree").setup(cfg)
    end,
}
