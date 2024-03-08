--local icon = require("common.icon")
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

-- key map
vim.api.nvim_create_autocmd( 'LspAttach', {
    callback = function(_)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})
        vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
    end,
})
-- diagnostic
vim.diagnostic.config({
    signs = true,
    underline = true,
    virtual_text = false,
    float = {
        border = "single",
        focusable = true,
    },
    severity_sort = true,
    update_in_insert = false,
})
