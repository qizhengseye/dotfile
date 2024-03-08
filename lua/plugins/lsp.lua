local lsps = {
    "lua_ls",
    "clangd",
    "rust_analyzer",
}
return {
    {
        "williamboman/mason.nvim",
        opts = {},
        lazy = true,
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = lsps,
        },
        lazy = true,
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        evnent = { "BufReadPost", "BufNewFile" },
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        opts = {
            languages = lsps,
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")

            local default_ls_cfg = require("custom.lsp.default_ls")
            for _, lspname in ipairs(opts.languages) do
                local success, custom_ls_cfg = pcall(require, "cumstom.lsp." .. lspname)
                local ls_cfg = success and custom_ls_cfg or default_ls_cfg
                lspconfig[lspname].setup(ls_cfg)
                require("custom.lsp")
            end
        end,
    },
}
