return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  cmd = "Telescope",
  keys = {
    {'<leader>ff', ":Telescope find_files<CR>", desc = 'Telescope find files' },
    {'<leader>fg', ":Telescope live_grep<CR>", desc = 'Telescope live grep' },
    {'<leader>fs', ":Telescope grep_string<CR>", desc = 'Telescope live grep' },
    {'<leader>fk', ":Telescope keymaps<CR>", desc = 'Telescope live grep' },
  },
  config = function()
    require('telescope').setup(require'editor.telescope')
  end
}
