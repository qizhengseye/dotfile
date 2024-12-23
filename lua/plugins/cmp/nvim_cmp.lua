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

          local max_width = vim.o.columns > G_CONF.ideal_width * 3 and G_CONF.ideal_width or math.floor(vim.o.columns / 3)
          item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
          })[entry.source.name]

          local remain_width = max_width - #item.menu - #item.kind
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
  },

  config = function(_, opt)
    vim.print(vim.o.columns)
    local cmp = require'cmp'
    local snip = vim.snippet

    opt.sources = cmp.config.sources({
      { name = 'nvim_lsp', trigger_charachers = {'.'},},
    },
    {
      { name = 'buffer' },
    })

    opt.mapping = {
      ["<C-p>"] = cmp.mapping.scroll_docs(-4),
      ["<C-n>"] = cmp.mapping.scroll_docs(4),
      ["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            if vim.bo.filetype == 'cpp' then
              local item = cmp.get_active_entry().completion_item
              local lable = cmp.get_selected_entry().completion_item.label
              if lable == ' private' or lable == ' public' then
                item.textEdit.range.start.character = 0
              end
            end
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ select = true }),
      }),
      ["<Tab>"] = cmp.mapping(
      {
        i = function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
          elseif snip.active({direction = 1}) then
            snip.jump(1)
            --elseif util.has_words_before() then
            --  cmp.complete()
          else
            fallback()
          end
        end,

        c = function (fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
          else
            cmp.complete()
          end
        end
      }
      ),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif snip.active({direction = -1}) then
          snip.jump(-1)
        else
          fallback()
        end
      end, { "i", "c" }),
    }
    cmp.setup(opt)
    
  end

}
