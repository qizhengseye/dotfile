return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },
  event = {'InsertEnter',},
  config = function()
    require("cmp").setup(require'cmp.nvim_cmp')
  end
}
