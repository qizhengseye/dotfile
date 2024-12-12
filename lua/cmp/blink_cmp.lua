local function supertab(cmp)
end

vim.api.nvim_set_hl(0, 'BlinkCmpGhostText', { link = 'NonText'})

local a = 0
local a_ = 0
local function label_hl(ctx)
   -- label and label details
  local highlights = {
    { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'Normal' },
  }
  if ctx.label_detail then
    table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
  end

  -- characters matched on the label by the fuzzy matcher
  for _, idx in ipairs(ctx.label_matched_indices) do
    table.insert(highlights, { idx, idx + 1, group = 'TelescopeMatching' })
  end

  if a_ == 0 then
    print('--------------')
    a = a + 1
    vim.print(highlights)
  end
  return highlights
end


local M = {
  keymap = {
    ["<c-e>"] = { "show", "show_documentation", "hide_documentation" },
    ["<c-x>"] = { "hide" },
    ["<c-y>"] = { "select_and_accept" },
    ["<cr>"] = { "select_and_accept", "fallback" },

    ["<m-k>"] = { "select_prev", "fallback" },
    ["<m-j>"] = { "select_next", "fallback" },

    ["<c-u>"] = { "scroll_documentation_up", "fallback" },
    ["<c-d>"] = { "scroll_documentation_down", "fallback" },

    ["<tab>"] = { "select_next","snippet_forward", "fallback" },
    ["<s-tab>"] = { "select_prev","snippet_backward", "fallback" },
  },

  -- Disables keymaps, completions and signature help for these filetypes
  blocked_filetypes = { "speedtyper", "help", "neo-tree" },
  appearance  = {
    use_nvim_cmp_as_default = true,
  },
  completion = {
    trigger = {
      show_on_blocked_trigger_characters = { ' ', '\n', '\t', '(', '{', "'", '"' },
      show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
    },

    menu = {
      border = G_CONF.popup.style,
      -- Controls how the completion items are rendered on the popup window
      draw = {
        -- Aligns the keyword you've typed to a component in the menu
        align_to_component = "label", -- or 'none' to disable
        -- Left and right padding, optionally { left, right } for different padding on each side
        padding = 1,
        -- Gap between columns
        gap = 1,
        -- Use treesitter to highlight the label text
        treesitter = false,

        -- Components to render, grouped by column
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 },
          { "test", gap = 1}
        },
        components = {
          test = {
            highlight = label_hl,
            text = function (ctx)
              if a == 0 then
                a = a + 1
                --vim.print(ctx)
              end
              return "test"
            end
          }
        }
      },
    },

    documentation = {
      -- Controls whether the documentation window will automatically show when selecting a completion item
      auto_show = true,
      -- Delay before showing the documentation window
      auto_show_delay_ms = 0,
      -- Delay before updating the documentation window when selecting a new item,
      -- while an existing item is still visible
      update_delay_ms = 50,
      -- Whether to use treesitter highlighting, disable if you run into performance issues
      treesitter_highlighting = true,
      window = {
        border = "single",
      },
    },

    ghost_text = {
      enabled = true,
    },
  },

  -- Experimental signature help support
  signature = {
    enabled = true,
    window = {
      border = "padded",
      -- Disable if you run into performance issues
      treesitter_highlighting = true,
    },
  },

  sources = {
    completion = {
      enabled_providers = function(_)
        local ok, node = pcall(vim.treesitter.get_node)
        if
          ok
          and node
          and vim.tbl_contains(
          { "comment", "line_comment", "block_comment" },
          node:type()
          )
          then
            return { "buffer", "path" }
          else
            return { "lsp", "path", "snippets", "buffer" }
          end
        end,
      },

      -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",

          enabled = true, -- Whether or not to enable the provider
          transform_items = nil, -- Function to transform the items before they're returned
          should_show_items = true, -- Whether or not to show the items
          max_items = nil, -- Maximum number of items to display in the menu
          min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
          fallback_for = {}, -- If any of these providers return 0 items, it will fallback to this provider
          score_offset = 0, -- Boost/penalize the score of the items
          override = nil, -- Override the source's functions
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          min_keyword_length = 3,
          score_offset = 3,
          opts = {
            show_hidden_files_by_default = true,
          },
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = -3,
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            global_snippets = { "all" },
            extended_filetypes = { "c", "cpp", "ejs" },
            ignored_filetypes = {},
          },
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          fallback_for = { "lsp" },
          min_keyword_length = 4,
        },
      },
    },
  }

  return M
