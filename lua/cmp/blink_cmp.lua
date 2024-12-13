local function supertab(cmp)
  local len = #require'blink.cmp.completion.list'.items
  if len == 1 then
    cmp.accept()
    return true
  end
  return false
end

vim.api.nvim_set_hl(0, 'BlinkCmpGhostText', { link = 'NonText'})

require('blink.cmp.keymap.presets').none = {}

local M = {
  keymap = {
    preset = "none",
    ["<c-e>"] = { "show", "show_documentation", "hide_documentation" },
    ["<cr>"] = { "select_and_accept", "fallback" },

    ["<m-k>"] = { "select_prev", "fallback" },
    ["<m-j>"] = { "select_next", "fallback" },

    ["<c-u>"] = { "scroll_documentation_up", "fallback" },
    ["<c-d>"] = { "scroll_documentation_down", "fallback" },

    ["<tab>"] = { supertab, "select_next","snippet_forward", "fallback" },
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
          { "source_name", gap = 1}
        },
        components = {
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
          { "comment", "line_comment", "block_comment", "string_content" },
          node:type()
          )
          then
            return { "buffer", "path" }
          else
            return { "lsp", "snippets", "buffer" }
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
          max_items = 100, -- Maximum number of items to display in the menu
          min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
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
          max_items = 50, -- Maximum number of items to display in the menu
          score_offset = -2,
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
          max_items = 50,
          score_offset = -2,
          min_keyword_length = 2,
          get_bufnrs = function()
            return vim
              .iter(vim.api.nvim_list_wins())
              :map(function(win) return vim.api.nvim_win_get_buf(win) end)
              :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
              :totable()
          end,
        },
      },
    },
  }

  return M
