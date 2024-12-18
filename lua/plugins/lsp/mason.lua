return {
    "williamboman/mason.nvim",
    opts = {},
    config = function(_, opt)
      require'mason'.setup(opt)
    end
}
