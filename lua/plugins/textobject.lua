return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufEnter",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local M = require("custom.textobj.tsobj")
      require("nvim-treesitter.configs").setup(M)
    end
  }
}
