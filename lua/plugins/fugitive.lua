return {
  "tpope/vim-fugitive",
  enabled = true,
  config = function()
    local map = require("utils.mapkey")
    map("n", "gs", "<cmd>Git<cr>", { silent = true, desc = "Git status" })
    map("n", "<leader>gd", "<cmd>Gvdiffsplit!<cr>", { silent = true, desc = "Git status" })
    map("n", "<leader>gl", "<cmd>Gllog<cr>", { silent = true, desc = "Git Log" })
    map("n", "<leader>gc", "<cmd>G commit<cr>", { silent = true, desc = "Git Vsplit diff" })

    map("n", "gm", function()
      vim.ui.input({ prompt = "Command Mode", completion = "buffer" }, function(input)
        if input then
          vim.cmd("diffget " .. input)
        end
      end)
    end)
    -- if vim.bo.filetype == "fugitive" then
    --   vim.keymap.set("n", "q", "<cmd>if bufnr('$') == 1|quit|else|bdelete|endif<cr>")
    --   vim.keymap.set("n", "<Tab>", "<cmd>execute <SNR>69_StageInline('toggle',line('.'),v:count)<cr>")
    --   vim.keymap.set("n", "<C-c><C-c>", "<cmd>wq<cr>", { desc = "Save and commit" })
    --   vim.keymap.set("n", "<C-c><c-k>", "<cmd>q!<cr>", { desc = "Abort commit" })
    -- else
    --   vim.keymap.set("n", "q", "<nop>")
    --   vim.keymap.set("n", "<Tab>", "<nop>")
    --   vim.keymap.set("n", "<C-c><C-c>", "<nop>", { desc = "Save and commit" })
    --   vim.keymap.set("n", "<C-c><c-k>", "<nop>", { desc = "Abort commit" })
    -- end
  end,
}
