return {
  "ibhagwan/fzf-lua",
  config = function()
    local fzf = require("fzf-lua")
    local map = require("custom.utils").map
    local actions = require("fzf-lua.actions")
    local custom = require("custom.fzf-custom")

    fzf.setup({
      fzf_colors = true,
      fzf_opts = {
        ["--layout"] = "default",
      },
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
    map("n", "<leader><leader>", fzf.files, { desc = "Project file" })
    map("n", "<leader>pr", fzf.oldfiles, { desc = "Recent Files" })
    -- git
    map("n", "<leader>pb", fzf.git_branches, { desc = "Git branches" })
    map("n", "<leader>pC", fzf.git_bcommits, { desc = "Git Current Buffer/File Commits" })
    map("n", "<leader>pc", fzf.git_commits, { desc = "Project Commits" })
    -- diagnostic
    -- map("n", "<leader>qw", fzf.diagnostics_workspace, { desc = "Workspace Diagnostics" })
    -- map("n", "<leader>qd", fzf.diagnostics_document, { desc = "Buffer Diagnostics" })
    -- qf
    map("n", "<leader>/", fzf.live_grep, { desc = "Grep string" })
    map("n", "<leader>pq", fzf.quickfix_stack, { desc = "Quickfix stack" })
    map("n", "<leader>*", fzf.grep_cword, { desc = "Grep cword" })
    map("v", "<leader>*", fzf.grep_visual, { desc = "Grep visual" })
    map("n", "<leader>ss", fzf.grep_curbuf, { desc = "Current Buffer Grep" })
    map("n", "<leader>sS", fzf.lines, { desc = "Current Buffer lines" })
    -- misc
    map("n", "<leader>pp", fzf.builtin, { desc = "FzfLua Builtin" })
    map("n", "<leader>'", fzf.resume, { desc = "Resume last FzfLua Action" })
    map("n", "<leader>,", fzf.buffers, { desc = "Current Opened Buffers" })
  end,
}
