return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = require "custom.icons".override,
    }
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "NMAC427/guess-indent.nvim"
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undo Tree" },
    },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_DiffpanelHeight = 15
    end,
  },
  {
    'stevearc/quicker.nvim',
    config = function()
      local quicker = require("quicker")
      local map = require("custom.utils").map
      quicker.setup({
        keys = {
          {
            ">",
            function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
            desc = "Expand quickfix context",
          },
          {
            "<", function() require("quicker").collapse() end, desc = "Collapse quickfix context",
          },
        },
        follow = {
          enabled = true
        },
      })
      map("n", "<leader>ql", function() quicker.toggle({ height = 10 }) end, { desc = "Toggle quickfix", })
      map("n", "<leader>qx", function() quicker.toggle({ loclist = true, height = 10 }) end, { desc = "Toggle loclist", })
    end
  },
  {
    'kevinhwang91/nvim-bqf',
    dependencies = {
      "junegunn/fzf"
    },
    ft = 'qf',
    opts = {
      preview = {
        auto_preview = true,
        win_height = 999,
        winblend = 10
      },
      filter  = {
        fzf = {
          extra_opts = { '--bind', 'ctrl-f:preview-half-page-down,ctrl-b:preview-half-page-up' }
        }
      }
    }
  }
}
