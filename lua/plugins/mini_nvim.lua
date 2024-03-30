return {
  {
    "echasnovski/mini.move",
    version = false,
    event = "BufEnter",
    config = function()
      require("mini.move").setup({
        mappings = {
          left = "<m-h>",
          right = "<m-l>",
          down = "<m-j>",
          up = "<m-k>",

          line_left = "<m-h>",
          line_right = "<m-l>",
          line_down = "<m-j>",
          line_up = "<m-k>",
        },
      })
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function ()
      require('mini.indentscope').setup()
    end
  },
}
