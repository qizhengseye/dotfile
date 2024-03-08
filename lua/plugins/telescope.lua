return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim'},
        event = "VeryLazy",
        opts = {

        },
        config = function(_, opts)
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {noremap = true, silent = true})
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {noremap = true, silent = true})
        end
    },
}
