return {
  {
    "tpope/vim-sleuth",
  },
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    opts = function(_, opts)
      opts.default_view = "headers_body"
      opts.winbar = true
    end,
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>wm", "<cmd>MaximizerToggle<cr>", "Maximze" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },
  {
    "NvChad/nvim-colorizer.lua",
    keys = {
      { "<leader>ch", "<cmd>ColorizerToggle<cr>", "show color" },
    },
    opts = {},
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        get_config = function(opts)
          if opts.kind == nil then
            return {
              relative = "editor",
              title_pos = "left",
            }
          end
        end,
      },
    },
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
