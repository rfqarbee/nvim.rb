return {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      enabled = false,
      build = "make",
    },
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local helper = require("helper.config_telescope")
    local map = require("custom.utils").map

    telescope.setup({
      defaults = {
        mappings = helper.telescope_mappings,
        buffer_previewer_maker = helper.telescope_new_maker,
        path_display = {
          truncate = 3,
          -- shorten = { len = 5, exclude = { 1, -2, -1 } },
        },
        vimgrep_arguments = helper.vimgrep_arguments,
        winblend = 0,
      },
      pickers = {
        find_files = helper.find_files,
        grep_string = helper.grep_string,
        buffers = helper.buffers,
        current_buffer_fuzzy_find = helper.current_buffer_fuzzy_find,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    pcall(telescope.load_extension, "fzf")

    vim.keymap.set("n", "<leader>f.", function()
      builtin.oldfiles({ only_cwd = true })
    end, { desc = "Recent files (extension)", noremap = true, silent = true })

    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    -- vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Find Git Files" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep current word" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fd", function()
      builtin.find_files({ find_command = { "fd", "-mindepth", "1", "--type", "d" } })
    end, { desc = "Find Directories" })
    vim.keymap.set("n", "<leader>fi", builtin.commands, { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

    vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search current buffer" })

    vim.keymap.set("n", "<leader>fo", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "Live grep open files" })

    vim.keymap.set("n", "<leader>fc", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Neovim config" })
  end,
}
