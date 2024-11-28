return {
    "williamboman/mason.nvim",
    config = function()
      require'mason'.setup(require('lsp.mason'))
    end
}
