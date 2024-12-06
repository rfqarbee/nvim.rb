return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    cond = function()
      local vault = "/home/rafiq/Documents/Vaults"
      local path = vim.fn.getcwd()
      if vault == path then
        return true
      else
        return false
      end
    end,
    ft = "markdown",
    config = function()
      local map = require("custom.utils").map
      require("obsidian").setup({
        workspaces = {
          {
            name = "notesidian",
            path = "~/Documents/Vaults",
            overrides = {
              daily_notes = {
                folder = "1. Dailies",
                date_format = "%Y-%m-%d",
                alias_format = "%B %-d,%Y",
                default_tags = { "dailies" },
              },
            },
          },
        },
        note_id_func = function(title)
          local suffix = ""
          if title ~= nil then
            suffix = title
          else
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end

          return suffix
        end,

        log_level = vim.log.levels.INFO,
        templates = {
          folder = "Templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
        },
        ui = {
          enable = false,
          checkboxes = {
            [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
            ["/"] = { char = "󰥔", hl_group = "ObsidianRightArrow" },
            [">"] = { char = "", hl_group = "ObsidianRightArrow" },
            ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
            ["!"] = { char = "", hl_group = "ObsidianImportant" },
          },
        },
        preferred_link_style = "wiki",
        mappings = {
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { desc = "GF passthru", noremap = false, expr = true, buffer = true },
          },
          ["<CR>"] = {
            action = function()
              return require("obsidian").util.smart_action()
            end,
            opts = { desc = "Smart action", expr = true, buffer = true },
          },
          ["<leader>oc"] = {
            action = function()
              return require("obsidian").util.toggle_checkbox()
            end,
            opts = { desc = "Toggle Checkbox (obs)", buffer = true },
          },
          ["<leader>on"] = {
            action = "<cmd>ObsidianDailies<cr>",
            opts = { desc = "Daily notes" },
          },
          ["<leader>od"] = {
            action = "<cmd>ObsidianToday +1<cr>",
            opts = { desc = "Notes Tomorrow" },
          },
          ["<leader>ox"] = {
            action = "<cmd>ObsidianTags<cr>",
            opts = { desc = "Obsidian Tags", buffer = true },
          },
          ["<leader>ot"] = { action = "<cmd>ObsidianTemplate<cr>", opts = { desc = "Template", buffer = true } },
          ["<leader>ov"] = {
            action = "<cmd>ObsidianBacklinks vsplit<cr>",
            opts = { desc = "ObsidianBacklinks", buffer = true },
          },
        },
      })
      map("v", "<leader>ol", ":ObsidianLinkNew<cr>", { desc = "Create obsidian link", buffer = true })
      map("v", "<leader>oe", ":ObsidianExtractNote<cr>", { desc = "Extract note and create links", buffer = true })
    end,
  },
}
