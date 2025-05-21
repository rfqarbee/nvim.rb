return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    completion = {
      list = { selection = { auto_insert = false, }, },
      menu = { draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } }, }, },
    },
    appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = "mono", kind_icons = require("custom.icons").completion_icons.my_icons, },
  },
}
