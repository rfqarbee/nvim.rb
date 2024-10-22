return {
  "rcarriga/nvim-notify",
  enabled = true,
  event = "VeryLazy",
  keys = {
    { "<leader><Esc>", "<cmd>lua require('notify').dismiss()<cr>", "Dismiss Notification" },
  },
  config = function()
    local notify = require("notify")
    vim.notify = notify
    notify.setup({
      render = "compact",
      fps = 240,
      stages = "static",
      top_down = false,
      timeout = 2500,
      max_height = function()
        return math.floor(vim.o.lines * 1.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.50)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    })

    local function show_file_info()
      local file_path = vim.fn.expand("%:h")
      -- :match("([^/]+)$")
      local message = ""

      if file_path == nil then
        return
      else
        message = file_path
        notify(message, "info", { title = "Path", top_down = false })
      end
    end

    vim.keymap.set("n", "<C-g>", function()
      show_file_info()
    end, { desc = "Show current file name" })
  end,
}
