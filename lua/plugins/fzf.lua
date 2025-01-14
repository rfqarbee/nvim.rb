return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    local map = require("custom.utils").map
    local actions = require("fzf-lua.actions")

    fzf.setup({
      fzf_colors = true,
      keymap = {
        builtin = {
          false,
          ["<M-p>"] = "toggle-preview",
          ["<Tab>"] = "preview-page-down",
          ["<S-Tab>"] = "preview-page-up",
        },
        fzf = {
          false, -- do not inherit from defaults
          ["shift-tab"] = "preview-page-up",
          ["tab"] = "preview-page-down",
          ["ctrl-o"] = "unix-line-discard",
          ["ctrl-c"] = "abort",
          ["ctrl-d"] = "half-page-down",
          ["ctrl-u"] = "half-page-up",
          ["ctrl-f"] = "toggle",
          ["ctrl-y"] = "toggle-all",
          ["alt-p"] = "toggle-preview",
        },
      },
      actions = {
        files = {
          ["enter"] = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["alt-q"] = actions.file_sel_to_qf,
          ["ctrl-a"] = actions.file_sel_to_ll,
          ["ctrl-q"] = { fn = actions.file_edit_or_qf, prefix = "select-all+" },
        },
      },
      buffers = {
        sort_lastused = false,
      },
      lsp = {
        code_actions = {
          winopts = { fullscreen = false },
        },
      },
      lines = {
        actions = {
          ["alt-q"] = actions.file_sel_to_qf,
          ["ctrl-a"] = actions.file_sel_to_ll,
          ["ctrl-q"] = { fn = actions.file_edit_or_qf, prefix = "select-all+" },
        },
      },
      builtin = {
        winopts = { fullscreen = false },
      },
      grep = {
        rg_glob = true,
        rg_glob_fn = function(query)
          local regex, flags = query:match("^(.-)%s%-%-(.*)$")
          return (regex or query), flags
        end,
      },
      diagnostics = {
        winopts = {
          split = "belowright new",
          fullscreen = false,
          backdrop = 100,
          preview = {
            hidden = "hidden",
          },
        },
      },
      files = {
        cwd_prompt = false,
        prompt = "Files > ",
      },
      git = {
        files = {
          cmd = "git ls-files --exclude-standard --recurse-submodules",
        },
      },
      oldfiles = {
        cwd_only = true,
        include_current_session = true,
      },
      helptags = { winopts = { fullscreen = false } },
      winopts = {
        fullscreen = true,
        preview = {
          vertical = "down:35%",
          horizontal = "right:40%",
        },
      },
    })
    -- using fzflua as the ui for select
    fzf.register_ui_select({ winopts = { fullscreen = false } })

    -- files
    map("n", "<leader>pf", fzf.files, { desc = "Project file" })
    map("n", "<leader>po", fzf.oldfiles, { desc = "Old Files" })
    -- git
    map("n", "<C-p>", fzf.git_files, { desc = "Open Git files" })
    map("n", "<leader>pb", fzf.git_branches, { desc = "Git branches" })
    map("n", "<leader>pC", fzf.git_bcommits, { desc = "Git Current Buffer/File Commits" })
    map("n", "<leader>pc", fzf.git_commits, { desc = "Project Commits" })
    -- qf
    map("n", "<leader>pq", fzf.quickfix_stack, { desc = "Quickfix stack" })
    map("n", "<leader>pS", fzf.grep, { desc = "Grep string" })
    map("n", "<leader>pW", fzf.grep_cWORD, { desc = "Grep cWORD" })
    map("n", "<leader>pw", fzf.grep_cword, { desc = "Grep cword" })
    map("v", "<leader>ps", fzf.grep_visual, { desc = "Grep visual" })
    map("n", "<leader>ps", fzf.live_grep_glob, { desc = "Live Grep" })
    map("n", "<leader>/", fzf.grep_curbuf, { desc = "Current Buffer Grep" })
    map("n", "<leader>pl", fzf.lines, { desc = "Current Buffer lines" })
    -- diagnostics
    map("n", "<leader>qd", fzf.diagnostics_document, { desc = "Diagnostics" })
    map("n", "<leader>qw", fzf.diagnostics_workspace, { desc = "Diagnostics" })
    -- misc
    map("n", "<leader>pp", fzf.builtin, { desc = "FzfLua Builtin" })
    map("n", "<leader>pr", fzf.resume, { desc = "Resume last FzfLua Action" })
    map("n", "<leader><leader>", fzf.buffers, { desc = "Current Opened Buffers" })
    map("n", "<leader>ph", fzf.helptags, { desc = "Help tags" })
  end,
}
