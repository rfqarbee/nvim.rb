return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  config = function()
    require("kulala").setup({
      default_env = "development",
      default_view = "headers_body",
      default_winbar_panes = { "headers_body", "body", "headers", "scripts_output", "stats" },
      winbar = true,
    })
    local map = require("custom.utils").map

    map("n", "<leader>kr", ":lua require('kulala').run()<cr>", { noremap = true, desc = "Run request" })
    map("n", "<leader>kc", ":lua require('kulala').copy()<cr>", { noremap = true, desc = "Copy to curl" })
    map("n", "<leader>pk", ":lua require('kulala').search()<cr>", { noremap = true, desc = "Search request" })
    map("n", "<leader>ki", ":lua require('kulala').inspect()<cr>", { noremap = true, desc = "Inspect" })
    map("n", "<M-j>", ":lua require('kulala').jump_next()<cr>", { noremap = true, desc = "Inspect" })
    map("n", "<M-k>", ":lua require('kulala').jump_prev()<cr>", { noremap = true, desc = "Inspect" })
    map("n", "<leader>ke", ":lua require('kulala').get_selected_env()<cr>", { noremap = true, desc = "Show stats" })
    map(
      "n",
      "<leader>ks",
      ":lua require('kulala').set_selected_env()<cr>",
      { noremap = true, desc = "Show stats", silent = true }
    )
  end,
}
