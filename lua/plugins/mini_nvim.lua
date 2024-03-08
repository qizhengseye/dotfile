return {
  "echasnovski/mini.move",
  version = false,
  event = "BufEnter",
  config = function()
    require("mini.move").setup({
      mappings = {
        left = "<C-S-H>",
        right = "<C-S-L>",
        down = "<C-S-J>",
        up = "<C-S-K>",

        line_left = "<C-S-H>",
        line_right = "<C-S-L>",
        line_down = "<C-S-J>",
        line_up = "<C-S-K>",
      },
    })
  end,
}
