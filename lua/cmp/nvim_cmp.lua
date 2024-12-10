local M = {}

local cmp = require'cmp'

M.window = {
  completion = { border = G_CONF.popup.style},
  documentation = { border = G_CONF.popup.style },
}

M.sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'path' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    },
    {
      { name = 'buffer' },
    })

return M
