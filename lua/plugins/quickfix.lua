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
      map("n", "<leader>ql", function() quicker.toggle({ height = 10 }) end, { desc = "Toggle quickfix", })
      map("n", "<leader>qx", function() quicker.toggle({ loclist = true, height = 10 }) end, { desc = "Toggle loclist", })
    end
  },
  -- {
  --   'kevinhwang91/nvim-bqf',
  --   dependencies = {
  --     "junegunn/fzf"
  --   },
  --   ft = 'qf',
  --   opts = {
  --     preview = {
  --       auto_preview = true,
  --       win_height = 999,
  --       winblend = 0
  --     },
  --     filter  = {
  --       fzf = {
  --         extra_opts = { '--bind', 'ctrl-f:preview-half-page-down,ctrl-b:preview-half-page-up' }
  --       }
  --     }
  --   }
  -- }
}
