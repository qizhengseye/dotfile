return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
      {"<leader>e", ":Neotree reveal toggle left<cr>", desc="Open NeoTree"}
    },
    opts = {},

    config = function(_, _)
        local cfg = require("editor.neotree")
        require("neo-tree").setup(cfg)
    end,
}
