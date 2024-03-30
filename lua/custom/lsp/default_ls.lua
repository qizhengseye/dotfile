local f_sig_help = function(bufnr)
  -- vim.keymap.set("i", "m-i", function ()
  -- require('lsp_signature').toggle_float_win()
  local opts = {
    floating_window = false,
    hint_enable = true,
    hint_prefix = "@",
    hint_scheme = "Comment",
    hint_inline = function ()
      return "eol"
    end,
    extra_trigger_chars = {"(", ","},
  } -- end)
  require'lsp_signature'.on_attach(opts, bufnr)
end

local _capab = require("cmp_nvim_lsp").default_capabilities()
_capab.textDocument.completion.completionItem.snippetSupport = false
_capab.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
return {
    on_attach = function (client, bufnr)
      f_sig_help(bufnr)
    end,
    capabilities = _capab,
    handlers =  {
        ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
        ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"}),
    },

}
