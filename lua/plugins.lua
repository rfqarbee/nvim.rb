return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = require "custom.icons".override,
    }
  },
  {
    'windwp/nvim-autopairs',
    dependencies = { 'windwp/nvim-ts-autotag', opts = {} },
    event = "InsertEnter",
    opts = {}
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup({})
    end
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
}
