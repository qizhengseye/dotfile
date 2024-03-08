return {
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = {},
        config = function()
            require("custom.cmp.snipconfig")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "hrsh7th/cmp-nvim-lsp",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-buffer",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-path",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-cmdline",
                event = "InsertEnter",
            },
            {
                "saadparwaiz1/cmp_luasnip",
                event = "InsertEnter",
            },
            {
                "L3MON4D3/LuaSnip",
                event = "InsertEnter",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
            },
            {
                "hrsh7th/cmp-nvim-lua",
            },
        },
        event = "InsertEnter",
        config = function()
            require("custom.cmp.nvimcmp")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
}
