local M = {
  experimental = {
    ghost_text = true
  }
}

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

M.mapping = cmp.mapping.preset.insert({
  ['<M-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  ['<M-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
})

return M
