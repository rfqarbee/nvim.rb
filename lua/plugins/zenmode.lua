return {
  {
    "folke/zen-mode.nvim",
    enabled = true,
    keys = {
      { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      on_open = function(win)
        local view = require("zen-mode.view")
        local layout = view.layout(view.opts)
        vim.api.nvim_win_set_config(win, {
          width = layout.width,
          height = layout.height - 1,
        })
        vim.api.nvim_win_set_config(view.bg_win, {
          width = vim.o.columns,
          height = view.height() - 1,
          row = 1,
          col = layout.col,
          relative = "editor",
        })
      end,
      window = {
        width = 0.90,
        options = {
          showtabline = 2,
        },
      },
      plugins = {
        twilight = { enabled = false },
        tmux = { enabled = false },
        kitty = {
          enabled = false,
          font = "+1",
        },
        todo = { enabled = false },
      },
    },
  },
}
