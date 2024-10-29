return {
  "tpope/vim-fugitive",
  enabled = true,
  config = function()
    local map = require("custom.utils").map
    map("n", "gs", "<cmd>Git<cr>", { silent = true, desc = "Git status" })
    map("n", "<leader>gd", "<cmd>Gvdiffsplit!<cr>", { silent = true, desc = "Git status" })
    map("n", "<leader>gl", "<cmd>Gllog<cr>", { silent = true, desc = "Git Log" })
    map("n", "<leader>gc", "<cmd>G commit<cr>", { silent = true, desc = "Git Vsplit diff" })

    map("n", "gh", "<cmd>diffget //2<cr>") -- changes from left
    map("n", "gl", "<cmd>diffget //3<cr>") -- changes from right
  end,
}
