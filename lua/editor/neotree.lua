local config = {
  close_if_last_window = true,
  enable_cursor_hijack = true,
  sort_case_insensitive = true,
  popup_border_style = G_CONF.popup.style,

  event_handlers = {
    {
      event = "neo_tree_popup_input_ready",
      handler = function()
        -- enter input popup with normal mode by default.
        vim.cmd("stopinsert")
      end,
    },
    {
      event = "neo_tree_popup_input_ready",
      ---@param args { bufnr: integer, winid: integer }
      handler = function(args)
        -- map <esc> to enter normal mode (by default closes prompt)
        -- don't forget `opts.buffer` to specify the buffer of the popup.
        vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
      end,
    }
  },

  default_component_configs = {
    name = {
      use_git_status_colors = false,
    },

    diagnostics = {
      symbols = {
        hint = G_ICON.diagnostics.Hint,
        info = G_ICON.diagnostics.Information,
        warn = G_ICON.diagnostics.Warning,
        error = G_ICON.diagnostics.Error,
      },
      highlights = {
        hint = "DiagnosticSignHint",
        info = "DiagnosticSignInfo",
        warn = "DiagnosticSignWarn",
        error = "DiagnosticSignError",
      },
    },

    git_status = {
      symbols = {
        -- Change type
        added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
        deleted   = "✖",
        modified  = "",
        renamed   = "󰁕",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "󰄱",
        staged    = "",
        conflict  = "",
      },
      align = "right",
    }
  },
  renderers = {
    directory = {
      { "indent" },
      { "icon" },
      { "current_filter" },
      {
        "container",
        content = {
          { "name", zindex = 10 },
          {
            "symlink_target",
            zindex = 10,
            highlight = "NeoTreeSymbolicLinkTarget",
          },
          { "clipboard", zindex = 10 },
          { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
        },
      },
    },
  },
  window = {
    mappings = {
      ["<cr>"] = function(state)
        local node = state.tree:get_node()
        if node and node.type == "file" then
          local cmd = require("neo-tree.sources.filesystem.commands")
          cmd.open(state)
        elseif node and node.type == "directory" then
          local cmd = require("neo-tree.sources.filesystem.commands")
          cmd.toggle_node(state)
        end
      end,
      ["<space>"] = "noop",
      ["<2-LeftMouse>"] = "",
      ["s"] = "open_split",
      ["S"] = "open_vsplit",
      ["a"] = {
        "add",
        config = {
          show_path = "relative",
        },
      },
      ["m"] = {
        "move",
        config = {
          show_path = "relative",
        },
      },
      ["c"] = {
        "copy",
        config = {
          show_path = "relative",
        },
      },
      ["f"] = "fuzzy_finder",
      ["F"] = "fuzzy_finder_directory",
      ["/"] = "noop",
      ["z"] = "close_node",
      ["Z"] = "close_all_nodes",
    },
  },
  filesystem = {
    window = {
      mappings = {
        ["<c-f>"] = function(state)
          local node = state.tree:get_node()
          if node and (node.type == "directory" or node.type == "file") then
            local live_grep = require("telescope.builtin").live_grep
            live_grep({
              search_dirs = {
                node:get_id()
              }
            })
          end
        end,
      },
      fuzzy_finder_mappings = {
        ["<C-n>"] = "move_cursor_down",
        ["<C-p>"] = "move_cursor_up",
      },
    },
    filtered_items = {
      visible = false,                    -- when true, they will just be displayed differently than normal items
      force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
      show_hidden_count = true,           -- when true, the number of hidden items in each folder will be shown as the last entry
      hide_dotfiles = true,
      hide_gitignored = false,
      hide_hidden = true, -- only orks on Windows for hidden files/directories
    },
  },
  buffers = {
    window = {
      mappings = {
        ["d"] = "buffer_delete",
      },
    },
  },
  git_status = {
    window = {
      mappings = {
        ["gg"] = "",
        ["gp"] = "",
      },
    },
  },
}

return config
