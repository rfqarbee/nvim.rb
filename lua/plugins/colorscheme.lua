return {
  -- {
  --   "darianmorat/gruvdark.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_enable_italic = true
    end,
  },
}
