return {
        "saghen/blink.cmp",
        version = "v0.*",
        event = {'InsertEnter',},
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat",
        },
        build = "cargo build --release",

        config = function()
          require('blink.cmp').setup(require('cmp.blink_cmp'))
        end
}
