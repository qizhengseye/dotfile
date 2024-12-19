local setup_lsp_client = require('util.lsp').setup_lsp_client

return {
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require'lspconfig'
      local def_cap = lspconfig.util.default_config.capabilities
      local cmp_cap = require('cmp_nvim_lsp').default_capabilities()
      lspconfig.util.default_config = vim.tbl_extend( "force",
        lspconfig.util.default_config,
        {
          capabilities = vim.tbl_extend("force", def_cap, cmp_cap)
        }
      )
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
