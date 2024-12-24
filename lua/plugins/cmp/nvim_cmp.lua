return {
  "iguanacucumber/magazine.nvim",
  name = "cmp-nvim", -- Otherwise highlighting gets messed up
  event = {'InsertEnter', 'CmdlineEnter'},
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

          local max_width = vim.o.columns > G_CONF.ideal_width * 3 and G_CONF.ideal_width or math.floor(vim.o.columns / 3)
          item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
          })[entry.source.name]

          local remain_width = max_width
            - (item.menu and #item.menu or 0)
            - (item.kind and #item.kind or 0)
          if remain_width <= 0 then
            remain_width = 10
          end

          if remain_width > #item.abbr then
            item.abbr = item.abbr .. string.rep(' ', remain_width - #item.abbr)
          else
            item.abbr = string.sub(item.abbr, 0, remain_width)
          end
          return item
        end
    },
    performance = {
      max_view_entries = G_CONF.cmp_item_cnt
    }
  },

  config = function(_, opt)
    local cmp = require'cmp'
    local cmp_util = require'util.completion'

    opt.sources = cmp.config.sources({
      { name = 'nvim_lsp', max_item_count = 50,},
      { name = 'buffer', max_item_count = 20 },
    })

    opt.mapping = {
      ["<C-p>"] = cmp.mapping.scroll_docs(-4),
      ["<C-n>"] = cmp.mapping.scroll_docs(4),
      ["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            if vim.bo.filetype == 'cpp' then
              local item = cmp.get_selected_entry().completion_item
              local lable = item.label
              if lable == ' private' or lable == ' public' then
                local indent = vim.fn.indent('.')
                local width = vim.bo.shiftwidth
                item.textEdit.range.start.character = indent > width and indent - width or 0
              end
            end
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
      }),
      ["<Tab>"] = cmp.mapping(
        {
          i = cmp_util.tab_i,
          c = cmp_util.tab_c,
        }
      ),
      ["<S-Tab>"] = cmp.mapping(
        {
          i = cmp_util.stab_i,
          c = cmp_util.stab_c,
        }
      ),
    }
    cmp.setup(opt)
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'cmdline' },
        { name = 'path' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
      completion = {
        autocomplete = false
      }
    })
  end

}
