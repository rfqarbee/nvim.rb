vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

fzf.setup({
  fzf_colors = true,
  grep = {
    rg_glob = true,
    rg_glob_fn = function(query)
      local regex, flags = query:match("^(.-)%s%-%-(.*)$")
      return (regex or query), flags
    end,
  },
  keymap = {
    builtin = {
      false,
      ["<M-=>"] = "toggle-preview",
      ["<m-n>"] = "preview-page-down",
      ["<m-p>"] = "preview-page-up",
    },
    fzf = {
      true, -- do not inherit from defaults
      ["alt-p"] = "preview-page-up",
      ["ctrl-q"] = "select-all+accept",
      ["alt-n"] = "preview-page-down",
      ["ctrl-o"] = "unix-line-discard",
      ["ctrl-c"] = "abort",
      ["ctrl-r"] = "toggle",
      ["alt-="] = "toggle-preview",
    },
  },
  winopts = {
    backdrop = 100,
    height = 0.75,
    width = 1,
    row = 0.9,
    col = 0,
    preview = {
      vertical = "down:35%",
      horizontal = "right:50%",
    },
  },
})

-- using fzflua as the ui for select
fzf.register_ui_select({ winopts = { fullscreen = false } })

-- files
vim.keymap.set("n", "<leader><leader>", fzf.files, { desc = "Project file" })
vim.keymap.set("n", "<leader>fd", function()
  fzf.files({
    fd_opts = [[--type d --exclude .git]],
  })
end, { desc = "Project directories" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent Files" })
-- git
vim.keymap.set("n", "<leader>pb", fzf.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>pC", fzf.git_bcommits, { desc = "Git Current Buffer/File Commits" })
vim.keymap.set("n", "<leader>pc", fzf.git_commits, { desc = "Project Commits" })
vim.keymap.set("n", "<leader>pd", fzf.git_diff, { desc = "git diff" })
-- diagnostic
-- vim.keymap.set("n", "<leader>qw", fzf.diagnostics_workspace, { desc = "Workspace Diagnostics" })
-- vim.keymap.set("n", "<leader>qd", fzf.diagnostics_document, { desc = "Buffer Diagnostics" })
-- qf
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Grep string" })
vim.keymap.set("n", "<leader>fq", fzf.quickfix_stack, { desc = "Quickfix stack" })
vim.keymap.set("n", "<leader>fw", fzf.grep_cword, { desc = "Grep cword" })
vim.keymap.set("v", "<leader>fw", fzf.grep_visual, { desc = "Grep visual" })
vim.keymap.set("n", "<leader>fs", fzf.grep_curbuf, { desc = "Current Buffer Grep" })
vim.keymap.set("n", "<leader>fl", fzf.lines, { desc = "Current Buffer lines" })
-- misc
vim.keymap.set("n", "<leader>fp", fzf.builtin, { desc = "FzfLua Builtin" })
vim.keymap.set("n", "<leader>'", fzf.resume, { desc = "Resume last FzfLua Action" })
vim.keymap.set("n", "<leader>bb", fzf.buffers, { desc = "Current Opened Buffers" })
