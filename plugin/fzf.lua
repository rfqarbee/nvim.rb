vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")
local actions = require("fzf-lua.actions")

fzf.setup({
  fzf_colors = true,
  fzf_opts = {
    ["--layout"] = "default",
  },
  grep = {
    rg_glob = true,
    rg_glob_fn = function(query)
      local regex, flags = query:match("^(.-)%s%-%-(.*)$")
      return (regex or query), flags
    end,
  },
  keymap = {
    builtin = { false, ["<M-=>"] = "toggle-preview", ["<m-n>"] = "preview-page-down", ["<m-p>"] = "preview-page-up" },
    fzf = {
      false, -- do not inherit from defaults
      ["alt-p"] = "preview-page-up",
      ["alt-n"] = "preview-page-down",
      ["ctrl-o"] = "unix-line-discard",
      ["ctrl-c"] = "abort",
      ["ctrl-d"] = "half-page-down",
      ["ctrl-u"] = "half-page-up",
      ["ctrl-r"] = "toggle",
      ["ctrl-y"] = "toggle-all",
      ["alt-="] = "toggle-preview",
    },
  },
  actions = {
    files = {
      ["enter"] = actions.file_edit_or_qf,
      ["ctrl-s"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
      ["ctrl-q"] = actions.file_sel_to_qf,
      ["ctrl-a"] = actions.file_sel_to_ll,
      ["alt-q"] = { fn = actions.file_sel_to_qf, prefix = "select-all+" },
    },
  },
  lines = {
    actions = {
      ["ctrl-q"] = actions.file_sel_to_qf,
      ["ctrl-a"] = actions.file_sel_to_ll,
      ["alt-q"] = { fn = actions.file_edit_or_qf, prefix = "select-all+" },
    },
  },
  -- git = custom.git,
  oldfiles = {
    cwd_only = true,
  },
  winopts = {
    backdrop = 100,
    height = 0.75,
    width = 1,
    row = 0.9,
    col = 0,
    preview = {
      vertical = "down:35%",
      horizontal = "right:40%",
    },
  },
})

-- using fzflua as the ui for select
fzf.register_ui_select({ winopts = { fullscreen = false } })

-- files
vim.keymap.set("n", "<c-p>", fzf.files, { desc = "Project file" })
vim.keymap.set("n", "<leader>fd", function()
  fzf.files({
    fd_opts = [[--type d --exclude .git]],
  })
end, { desc = "Project directories" })
vim.keymap.set("n", "<leader>.", fzf.oldfiles, { desc = "Recent Files" })
-- git
vim.keymap.set("n", "<leader>pb", fzf.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>gL", fzf.git_bcommits, { desc = "Git Current Buffer/File Commits" })
vim.keymap.set("n", "<leader>gl", fzf.git_commits, { desc = "Project Commits" })
-- diagnostic
-- vim.keymap.set("n", "<leader>qw", fzf.diagnostics_workspace, { desc = "Workspace Diagnostics" })
-- vim.keymap.set("n", "<leader>qd", fzf.diagnostics_document, { desc = "Buffer Diagnostics" })
-- qf
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Grep string" })
vim.keymap.set("n", "<leader>pq", fzf.quickfix_stack, { desc = "Quickfix stack" })
vim.keymap.set("n", "<leader>pw", fzf.grep_cword, { desc = "Grep cword" })
vim.keymap.set("v", "<leader>pw", fzf.grep_visual, { desc = "Grep visual" })
vim.keymap.set("n", "<leader>ps", fzf.grep_curbuf, { desc = "Current Buffer Grep" })
vim.keymap.set("n", "<leader>pl", fzf.lines, { desc = "Current Buffer lines" })
-- misc
vim.keymap.set("n", "<leader>pp", fzf.builtin, { desc = "FzfLua Builtin" })
vim.keymap.set("n", "<leader>'", fzf.resume, { desc = "Resume last FzfLua Action" })
vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "Current Opened Buffers" })
