local setup_lsp_client = require('util.lsp').setup_lsp_client;

return {
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require('lsp.lspconfig')
      for lsp, ft in pairs(G_CONF.required_lsp) do
        local ok, cfg = pcall(require, "lsp.server." .. lsp)
        if ok then
          setup_lsp_client(ft, lsp, cfg)
        else
          print(string.format('no config for %s, use default', lsp))
          setup_lsp_client(ft, lsp, {})
        end
      end
    end
}
