return {
  {
    "EvWilson/spelunk.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local map = require("custom.utils").map
      require("spelunk").setup({
        base_mappings = {
          toggle = '\\',
          add = '<leader>a',
          next_bookmark = '<M-k>',
          prev_bookmark = '<M-j>',
          -- search_bookmarks = '<leader>bf',
          -- search_current_bookmarks = '<leader>bc',
        },
        window_mappings = {
          cursor_down = "j",
          cursor_up = "k",
          bookmark_down = "J",
          bookmark_up = "K",
          goto_bookmark = "<CR>",
          goto_bookmark_hsplit = "x",
          goto_bookmark_vsplit = "v",
          delete_bookmark = "d",
          next_stack = "<Tab>",
          previous_stack = "<S-Tab>",
          new_stack = "n",
          delete_stack = "D",
          edit_stack = "E",
          close = "q",
          help = "h",
        },

        enable_persist = true,
        statusline_prefix = "🔖",
      })

      map("n", "<leader>1", function()
        require("spelunk").goto_bookmark_at_index(1)
      end)
      map("n", "<leader>2", function()
        require("spelunk").goto_bookmark_at_index(2)
      end)
      map("n", "<leader>3", function()
        require("spelunk").goto_bookmark_at_index(3)
      end)
      map("n", "<leader>4", function()
        require("spelunk").goto_bookmark_at_index(4)
      end)
    end,
  },
}
