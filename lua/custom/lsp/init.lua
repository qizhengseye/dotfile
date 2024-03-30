--local icon = require("common.icon")
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

-- key map
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- local bufnr = args.buf

    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.inlay_hint.enable(bufnr, true)
    -- else
    --   print("no inlay hints available")
    -- end
    vim.keymap.set("n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {})
    vim.keymap.set("n", "gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", {})
    vim.keymap.set("n", "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", {})
    vim.keymap.set("n", "gD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", {})
    vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').close_all_win()<CR>", {})
    vim.keymap.set("n", "gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {})
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})
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
    border = "rounded",
    focusable = true,
  },
  severity_sort = true,
  update_in_insert = false,
})
