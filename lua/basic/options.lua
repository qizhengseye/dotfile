-- temp files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.writebackup = false

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect"}

-- appearance 
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.conceallevel = 0
vim.opt.cursorline = true

-- search option
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- split position
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

-- tab space and indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = "space:·"

-- mappings
vim.opt.timeoutlen = 3000
