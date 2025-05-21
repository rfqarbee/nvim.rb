local M = {}

M.files = {
  winopts = {
    fullscreen = true
  }
}

M.builtin = {
  false,
  ["<M-p>"] = "toggle-preview",
  ["<Tab>"] = "preview-page-down",
  ["<S-Tab>"] = "preview-page-up",
}

M.fzf = {
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
}
M.winopts = {
  preview = {
    vertical = "down:35%",
    horizontal = "right:40%",
  },
}

M.git = {
  files = {
    winopts = {
      fullscreen = true
    },
    cmd = "git ls-files --exclude-standard --recurse-submodules",
  },
}

M.buffers = {
  sort_lastused = false,
}

M.oldfiles = {
  winopts = {
    fullscreen = true
  },
  cwd_only = true,
  include_current_session = true,
}

M.actions = function(actions)
  return {
    files = {
      ["enter"] = actions.file_edit_or_qf,
      ["ctrl-s"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
      ["ctrl-q"] = actions.file_sel_to_qf,
      ["ctrl-a"] = actions.file_sel_to_ll,
      ["alt-q"] = { fn = actions.file_edit_or_qf, prefix = "select-all+" },
    },
  }
end

M.lines = function(actions)
  return {
    actions = {
      ["ctrl-q"] = actions.file_sel_to_qf,
      ["ctrl-a"] = actions.file_sel_to_ll,
      ["alt-q"] = { fn = actions.file_edit_or_qf, prefix = "select-all+" },
    },
  }
end


return M
