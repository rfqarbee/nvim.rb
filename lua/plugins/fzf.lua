return {
  "ibhagwan/fzf-lua",
  config = function()
    local fzf = require("fzf-lua")
    local map = require("custom.utils").map
    local actions = require("fzf-lua.actions")
    local custom = require("custom.fzf-custom")

    fzf.setup({
      fzf_colors = true,
      grep = custom.grep,
      keymap = {
        builtin = custom.builtin,
        fzf = custom.fzf,
      },
      buffers = custom.buffers,
      actions = custom.actions(actions),
      lines = custom.lines(actions),
      files = custom.files,
      git = custom.git,
      oldfiles = custom.oldfiles,
      winopts = custom.winopts,
    })
    -- using fzflua as the ui for select
    fzf.register_ui_select({ winopts = { fullscreen = false } })

    -- files
    map("n", "<C-n>", fzf.files, { desc = "Project file" })
    map("n", "<C-p>", fzf.git_files, { desc = "Open Git files" })
    map("n", "<leader>po", fzf.oldfiles, { desc = "Old Files" })
    -- git
    map("n", "<leader>pb", fzf.git_branches, { desc = "Git branches" })
    map("n", "<leader>pC", fzf.git_bcommits, { desc = "Git Current Buffer/File Commits" })
    map("n", "<leader>pc", fzf.git_commits, { desc = "Project Commits" })
    -- qf
    map("n", "<leader>ps", fzf.live_grep, { desc = "Grep string" })
    map("n", "<leader>pq", fzf.quickfix_stack, { desc = "Quickfix stack" })
    map("n", "<leader>pS", fzf.grep, { desc = "Grep string" })
    map("n", "<leader>pw", fzf.grep_cword, { desc = "Grep cword" })
    map("v", "<leader>pw", fzf.grep_visual, { desc = "Grep visual" })
    map("n", "<leader>ph", fzf.help_tags, { desc = "Grep cword" })
    map("n", "<leader>/", function() fzf.grep_curbuf({ winopts = { fullscreen = true } }) end,
      { desc = "Current Buffer Grep" })
    map("n", "<leader>pl", function()
      fzf.lines({ winopts = { fullscreen = true } })
    end, { desc = "Current Buffer lines" })
    -- misc
    map("n", "<leader>pp", fzf.builtin, { desc = "FzfLua Builtin" })
    map("n", "<leader>pr", fzf.resume, { desc = "Resume last FzfLua Action" })
    map("n", "<leader><leader>", fzf.buffers, { desc = "Current Opened Buffers" })
  end,
}
