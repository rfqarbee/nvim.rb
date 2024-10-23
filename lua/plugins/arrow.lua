return {
  "otavioschwanck/arrow.nvim",
  lazy = true,
  opts = function(_, opts)
    opts.hide_handbook = false
    opts.show_icons = true
    opts.leader_key = "\\"
    opts.buffer_leader_key = "'"
    opts.mappings = {
      next_item = "j",
      prev_item = "k",
    }
    opts.window = { -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
      width = 120,
      height = 15,
      row = 10,
      col = 30,
      border = "single",
    }
    opts.per_buffer_config = {
      lines = 5,
    }
    vim.keymap.set("n", "<leader>1", function()
      require("arrow.persist").go_to(1)
    end)
    vim.keymap.set("n", "<leader>2", function()
      require("arrow.persist").go_to(2)
    end)
    vim.keymap.set("n", "<leader>3", function()
      require("arrow.persist").go_to(3)
    end)
    vim.keymap.set("n", "<leader>4", function()
      require("arrow.persist").go_to(4)
    end)
    vim.keymap.set("n", "<leader>a", function()
      require("arrow.persist").toggle()
    end)
  end,
}
