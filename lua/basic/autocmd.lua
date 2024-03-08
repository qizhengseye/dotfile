vim.cmd("autocmd FileType norg setlocal shiftwidth=2 softtabstop=2 wrap conceallevel=2")

vim.api.nvim_create_user_command("MyConfig", ":e $MYVIMRC | :cd %:p:h", {})
