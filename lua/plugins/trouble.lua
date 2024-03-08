return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>tt",
      function()
        require("trouble").toggle()
      end,
    },
    {
      "<leader>tw",
      function()
        require("trouble").toggle("workspace_diagnostics")
      end,
    },
    {
      "<leader>td",
      function()
        require("trouble").toggle("document_diagnostics")
      end,
    },
    {
      "<leader>tq",
      function()
        require("trouble").toggle("quickfix")
      end,
    },
    {
      "<leader>xl",
      function()
        require("trouble").toggle("loclist")
      end,
    },
    {
      "gR",
      function()
        require("trouble").toggle("lsp_references")
      end,
    },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
