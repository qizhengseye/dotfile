return {
  "Wansmer/treesj",
  keys = { { "<space>m", ":TSJToggle<CR>" } },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({
      use_default_keymaps = false
      --[[ your config ]] })
  end,
}
