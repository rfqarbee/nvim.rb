return {
  {
    'stevearc/quicker.nvim',
    config = function()
      local quicker = require("quicker")
      local map = require("custom.utils").map
      quicker.setup({
        follow = {
          enabled = true
        },
      })
      map("n", "<leader>qx", function() quicker.toggle({ height = 10 }) end, { desc = "Toggle quickfix", })
      map("n", "<leader>ql", function() quicker.toggle({ loclist = true, height = 10 }) end, { desc = "Toggle loclist", })
    end
  },
}
