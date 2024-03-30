return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                style_preset = bufferline.style_preset.default,
                themable = true,
                right_mouse_command = false,
                left_mouse_command = false,
                middle_mouse_command = false,
                close_command = false,
                diagnostics_indicator = false,
                diagnostics = "nvim_lsp",
                buffer_close_icon = "",
                show_buffer_close_icon = false,
                always_show_bufferline = true,
                hover = { enable = false },
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
--                       separator = '|',
                        padding = 0,
                    },
                },
            },
        })
    end,
}
