local icon = require("common.icon")
local config = {
  default_component_configs = {
    diagnostics = {

      symbols = {
        hint = icon.diagnostics.Hint,
        info = icon.diagnostics.Info,
        warn = icon.diagnostics.Warn,
        error = icon.diagnostics.Error,
      },
      highlights = {
        hint = "DiagnosticSignHint",
        info = "DiagnosticSignInfo",
        warn = "DiagnosticSignWarn",
        error = "DiagnosticSignError",
      },
    },
  },
  close_if_last_window = true,
  enable_normal_mode_for_inputs = true,
  enable_cursor_hijack = true,
  sort_case_insensitive = true,
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
        ["<C-n>"] = "noop",
        ["<C-p>"] = "noop",
        ["<m-j>"] = "move_cursor_down",
        ["<m-k>"] = "move_cursor_up",
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
