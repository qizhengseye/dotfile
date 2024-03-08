local _capab = require("cmp_nvim_lsp").default_capabilities()
_capab.textDocument.completion.completionItem.snippetSupport = false
_capab.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
return {
    capabilities = _capab,
    handlers =  {
        ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}),
        ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"}),
    },

}
