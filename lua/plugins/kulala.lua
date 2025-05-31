return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>ra", desc = "Send all requests" },
    { "<leader>rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    ui = {
      formatter = true,
    },
    global_keymaps = true,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
  },
}
