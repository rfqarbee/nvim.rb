return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    local map = require("utils.mapkey")
    local helper = require("helper.config_fzf")

    fzf.setup({
      fzf_colors = true,
      grep = helper.grep_opts,
      keymap = {
        fzf = {
          false, -- do not inherit from defaults
          ["tab"] = "",
          ["shift-tab"] = "",
          ["ctrl-c"] = "abort",
          ["ctrl-d"] = "half-page-down",
          ["ctrl-u"] = "half-page-up",
          ["ctrl-f"] = "toggle",
          ["ctrl-y"] = "toggle-all",
          ["alt-p"] = "toggle-preview",
          ["ctrl-j"] = "preview-page-down",
          ["ctrl-k"] = "preview-page-up",
        },
      },
      actions = {
        files = helper.files,
      },
      files = {
        cwd_prompt = false,
        prompt = "Files > ",
      },
      winopts = {
        border = "single",
        preview = {
          hidden = "hidden",
          default = "bat",
          horizontal = "right:50%",
        },
      },
    })

    -- files
    map("n", "<leader>pf", fzf.files, { desc = "Project file" })
    map("n", "<leader>po", fzf.oldfiles, { desc = "old files" })
    -- git
    map("n", "<C-p>", fzf.git_files, { desc = "Git files" })
    map("n", "<leader>pb", fzf.git_branches, { desc = "Git branches" })
    map("n", "<leader>pc", fzf.git_bcommits, { desc = "Git Current Buffer Commits" })
    map("n", "<leader>pC", fzf.git_commits, { desc = "PWD Git commits" })
    -- qf
    map("n", "<leader>pq", fzf.quickfix_stack, { desc = "qf stack" })
    map("n", "<leader>pl", fzf.loclist_stack, { desc = "loclist stack" })
    -- grep
    map("n", "<leader>pS", function()
      vim.ui.input({ prompt = "Grep > " }, function(search)
        if search ~= nil then
          fzf.grep({ search = search, no_esc = true })
        end
      end)
    end, { desc = "Grep" })
    map("n", "<leader>pW", fzf.grep_cWORD, { desc = "grep cWORD" })
    map("n", "<leader>pw", fzf.grep_cword, { desc = "grep cword" })
    map("v", "<leader>sp", fzf.grep_visual, { desc = "Grep visual" })
    map("n", "<leader>sp", function()
      fzf.live_grep({ resume = true })
    end, { desc = "Project live grep" })
    map("n", "<leader>sb", fzf.grep_curbuf, { desc = "Fuzzy find current buffer" })
    map("n", "<leader>sl", fzf.blines, { desc = "Current Buffer lines" })
    -- misc
    map("n", "<leader>pp", fzf.builtin, { desc = "Builtin" })
    map("n", "<leader>pr", fzf.resume, { desc = "resume last " })
    map("n", "<leader>bi", fzf.buffers, { desc = "Fuzzy find current buffer" })
    map("n", "<leader>ph", fzf.helptags, { desc = "Project file" })
  end,
}
