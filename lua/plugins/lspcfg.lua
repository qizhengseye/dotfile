return {
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require'lspconfig'.lua_ls.setup(require'lsp.server.lua_ls')
    end
}
