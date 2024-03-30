return {
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  build = ":TSUpdate",
  opts = {
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "python", "lua", "cpp", "rust", "vim", "vimdoc" },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlightig = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "L", -- set to `false` to disable one of the mappings
          node_incremental = "L",
          scope_incremental = false,
          node_decremental = "H",
        },
      },
    })
  end
}
