local cmp = require("cmp")
local luasnip = require("luasnip")
local util = require("utils")
local icon = require("common.icon")
local window = cmp.config.window.bordered()
local types = require("cmp.types")

local function intellece_source_filter()
  local context = require 'cmp.config.context'
  if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
    return false
  end
  if context.in_syntax_group("String") or context.in_treesitter_capture("string") then
    return false
  end
  return true
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require("luasnip").lsp_expand(args.body)       -- For `luasnip` users.
    end,
  },
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = window,
    documentation = window,
  },
  performance = {
    max_view_entries = 20,
  },
  matching = {
    disallow_prefix_unmatching = false,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.scroll_docs(-4),
    ["<C-n>"] = cmp.mapping.scroll_docs(4),
    ["<m-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }), { "i", "c" }),
    ["<m-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if #cmp.get_entries() == 1 then
          cmp.confirm({ select = true })
        else
          cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
        end
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif util.has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sorting = {
    comparators = {
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      cmp.config.compare.length,
      cmp.config.compare.kind,
    },
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", icon.kind[vim_item.kind], vim_item.kind)       -- This concatenates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end,
  },

  sources = cmp.config.sources({
    {
      name = "luasnip",
      entry_filter = function(entry)
        return intellece_source_filter()
      end,
    },     -- For luasnip users.
    {
      name = "nvim_lsp",
      entry_filter = function(entry)
        local context = require 'cmp.config.context'
        if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
          return false
        end
        if context.in_syntax_group("String") or context.in_treesitter_capture("string") then
          return cmp.lsp.CompletionItemKind.File == entry:get_kind()
        end
        return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
      end,
    },
  }, 
  {
    { name = "buffer" },
    { name = "path" },
  }),
})

cmp.setup.filetype("norg", {
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  view = {
    entries = { name = "wildmenu", separator = "|" },
  },
  sources = {
    { name = "buffer" },
  },
  mapping = cmp.mapping.preset.cmdline(),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  formatting = {
    fields = { "abbr" },
  },
})
