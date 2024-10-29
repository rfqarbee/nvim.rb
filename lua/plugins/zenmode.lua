return {
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>wm", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        width = 0.70,
      },
      plugins = {
        options = {
          showcmd = true,
          laststatus = 3,
        },
        twilight = { enabled = false },
        tmux = { enabled = false },
        todo = { enabled = false },
      },
    },
  },
}
