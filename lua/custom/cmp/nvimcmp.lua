local cmp = require("cmp")
local luasnip = require("luasnip")
local util = require("utils")
local icon = require("common.icon")
local window = cmp.config.window.bordered()
local types = require("cmp.types")
window.max_height = 10

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
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
      max_view_entries = 10,
    },
    matching = {
      disallow_partial_fuzzy_matching = true,
      disallow_prefix_unmatching = false,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<m-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<m-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
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
                cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif util.has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-p>"] = nil,
        ["<C-n"] = nil,
    }),
    sorting = {
        comparators = {
            cmp.config.compare.recently_used,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            util.lsp_kind_compare(types.lsp.CompletionItemKind.Keyword),
            util.lsp_kind_compare(types.lsp.CompletionItemKind.Variable),
            cmp.config.compare.score,
            cmp.config.compare.kind,
        },
    },

    enabled = function()
        local context = require("cmp.config.context")
        if vim.bo.buftype == "prompt" then
            return false
        end
        if vim.api.nvim_get_mode().mode == "c" then
            return true
        end
        if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
            return false
        end
        if context.in_syntax_group("String") or context.in_treesitter_capture("string") then
            return false
        end
        return true
    end,
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", icon.kind[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
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
        { name = "luasnip", }, -- For luasnip users.
        { name = "nvim_lsp", entry_filter = function(entry)
                return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
            max_item_count = 10},
    }, {
        { name = "buffer" },
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
