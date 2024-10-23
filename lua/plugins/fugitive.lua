return {
  "tpope/vim-fugitive",
  enabled = true,
  config = function()
    local map = require("custom.utils").map
    map("n", "gs", "<cmd>Git<cr>", { silent = true, desc = "Git status" })
    map("n", "<leader>gd", "<cmd>Gvdiffsplit!<cr>", { silent = true, desc = "Git status" })
    map("n", "<leader>gl", "<cmd>Gllog<cr>", { silent = true, desc = "Git Log" })
    map("n", "<leader>gc", "<cmd>G commit<cr>", { silent = true, desc = "Git Vsplit diff" })

    -- if vim.bo.filetype == "fugitive" then
    --   vim.keymap.set("n", "q", "<cmd>if bufnr('$') == 1|quit|else|bdelete|endif<cr>")
    --   vim.keymap.set("n", "<C-c><C-c>", "<cmd>wq<cr>", { desc = "Save and commit" })
    --   vim.keymap.set("n", "<C-c><c-k>", "<cmd>q!<cr>", { desc = "Abort commit" })
    map("n", "gh", "<cmd>diffget //2<cr>") -- changes from left
    map("n", "gl", "<cmd>diffget //3<cr>") -- changes from right
    -- end
  end,
}
