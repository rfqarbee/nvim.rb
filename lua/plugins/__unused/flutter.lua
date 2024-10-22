return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  enabled = false,
  ft = "dart",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    require("flutter-tools").setup({})

    local map = function(lhs, rhs, opts)
      vim.keymap.set("n", lhs, rhs, { desc = opts })
    end

    map("<leader>lo", "<cmd>FlutterOutlineToggle<cr>", "Flutter Outline Toggle")
    map("<leader>ld", "<cmd>FlutterDevToolsActivate<cr>", "Flutter Dev Tools Activate")
    map("<leader>lr", "<cmd>FlutterLspRestart<cr>", "Flutter Restart LSP")
    map("<leader>ls", "<cmd>FlutterSuper<cr>", "Flutter Super Class")
    map("<leader>ln", "<cmd>FlutterRename<cr>", "Flutter Rename")
  end,
}
