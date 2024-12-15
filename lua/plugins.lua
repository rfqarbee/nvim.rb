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
    "stevearc/dressing.nvim",
    enabled = true,
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
