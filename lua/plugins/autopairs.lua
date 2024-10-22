return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      events = { "BufReadPre", "BufNewFile" },
    },
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        disable_filetype = { "TelescopePrompt", "oil", "trouble", "undotree" },
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close_on_slash = true,
        },
      })
    end,
  },
}
