return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    -- Your setup opts here
    outline_window = {
      focus_on_open = false,
      winhl = "Normal:NeotreeTabSplitorInactive"
    },
    outline_items = {
      show_symbol_lineno = true,
    },
    keymaps = {
      close = 'q',
      fold_toggle = "z",
      fold_toggle_all = "Z",
    }
  },
}
