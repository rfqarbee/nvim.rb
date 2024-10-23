return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  enabled = false,
  keys = {
    {
      "<leader>k",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local w = require("which-key")
    w.setup({
      icons = {
        mappings = false,
      },
      plugins = {
        marks = true,
        registers = false,
        spelling = {
          enabled = true,
        },
      },
    })
    w.add({
      { "<leader>h", group = "Harpoon : " },
      { "<leader>f", group = "Telescope : " },
      { "<leader>p", group = "FzfTelescope : " },
      { "<leader>q", group = "Trouble : " },
      { "<leader>l", group = "LSP : " },
      { "<leader>g", group = "Git : " },
      { "<leader>d", group = "Dap : " },
      { "<leader>w", group = "Workspace : " },
      { "<leader>k", group = "Curl : " },
      { "<leader>c", group = "Lsp (Telescope) : " },
    })
  end,
}
