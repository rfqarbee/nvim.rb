return {
  {
    "stevearc/oil.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require("oil")
      local map = require("custom.utils").map

      oil.setup({
        columns = {
          "icon",
        },
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
        },
        float = {
          border = "single",
          padding = 7,
          max_width = 0,
          max_height = 60,
          win_options = {
            winblend = 0,
          },
        },
        natural_order = false,
        use_default_keymaps = false,
        delete_to_trash = true, -- in $XDG_DATA_HOME/Trash
        skip_confirm_for_simple_edits = true,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<M-p>"] = "actions.preview",
          ["q"] = "actions.close",
          ["<space>r"] = "actions.refresh", -- refresh list
          -- ["<space>-"] = "actions.parent",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["."] = "actions.cd", -- change project directory
          ["`"] = "actions.tcd", -- change current tab directory
          ["<leader>gs"] = "actions.change_sort",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
      })
      map("n", "<leader>-", function()
        require("oil").open_float()
      end, { desc = "Float oil" })
      map("n", "-", function()
        require("oil").open()
      end, { desc = "Oil -> Directory" })
    end,
  },
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    enabled = true,
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
