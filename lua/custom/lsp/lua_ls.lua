local default_config = require("custom.lsp.default_ls")
default_config.setttings = {
  format = {
    enable = false,
    defaultconfig = {
      indent_style = "space",
    },
  },
}

return default_config
