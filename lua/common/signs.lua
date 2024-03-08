local icon = require("common.icon")

vim.fn.sign_define("DiagnosticSignError", { text = icon.diagnostics.Error, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = icon.diagnostics.Warning, texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = icon.diagnostics.Information, texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = icon.diagnostics.Hint, texthl = "DiagnosticSignHint" })


