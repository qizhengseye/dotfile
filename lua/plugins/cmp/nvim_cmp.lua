return {
  "iguanacucumber/magazine.nvim",
  name = "cmp-nvim", -- Otherwise highlighting gets messed up
  event = {'InsertEnter',},
  dependencies = {
    { "iguanacucumber/mag-nvim-lsp" },
    { "iguanacucumber/mag-buffer" },
    { "iguanacucumber/mag-cmdline" },
  },
  opts = {
    experimental = {
      ghost_text = true
    },
    window = {
      completion = { border = G_CONF.popup.style},
      documentation = { border = G_CONF.popup.style },
    },
    formatting = {
      expandable_indicator = true,
      fields = { 'abbr', 'kind', 'menu'},
      format = function(entry, item)
          if item.kind and G_ICON.kind[item.kind] then
            item.kind = G_ICON.kind[item.kind] .. " " .. item.kind
          end

          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          }

          item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
          })[entry.source.name]

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
            end
          end

          return item
        end
    },
  },

  config = function(_, opt)
    local cmp = require'cmp'

    opt.sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    },
    {
      { name = 'buffer' },
    })

    opt.mapping = cmp.mapping.preset.insert({
      ['<M-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<M-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    })
    require('cmp').setup(opt)
  end

}
