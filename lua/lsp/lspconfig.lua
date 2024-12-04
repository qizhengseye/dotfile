local lspconfig = require'lspconfig'
local def_cap = lspconfig.util.default_config.capabilities
local cmp_cap = require('cmp_nvim_lsp').default_capabilities()

lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    capabilities = vim.tbl_extend("force", def_cap, cmp_cap)
  })
