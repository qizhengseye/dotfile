local config = {
  close_if_last_window = true,
  enable_normal_mode_for_inputs = true,
  enable_cursor_hijack = true,
  sort_case_insensitive = true,
  window = {
    mappings = {
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
          print(node.path)
          local live_grep = require("telescope.builtin").live_grep
          live_grep({
            search_dirs = {
              node.path
            }
          })
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