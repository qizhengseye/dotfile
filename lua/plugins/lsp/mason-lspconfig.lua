return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    config = function()
      require("mason-lspconfig").setup()
    end
}
