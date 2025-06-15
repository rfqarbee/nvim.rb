local M = {}

M.grep = {
  winopts = {
    fullscreen = true,
  },
  rg_glob = true,
  rg_glob_fn = function(query)
    local regex, flags = query:match("^(.-)%s%-%-(.*)$")
    return (regex or query), flags
  end,
}

M.files = {
  winopts = {
    fullscreen = true,
  },
}

M.builtin = {
  false,
  ["<M-=>"] = "toggle-preview",
  ["<m-n>"] = "preview-page-down",
  ["<m-p>"] = "preview-page-up",
}

M.fzf = {
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
      fullscreen = true,
    },
    cmd = "git ls-files --exclude-standard --recurse-submodules",
  },
}

M.buffers = {
  sort_lastused = false,
}

M.oldfiles = {
  winopts = {
    fullscreen = true,
  },
  cwd_only = true,
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
      ["alt-q"] = { fn = actions.file_sel_to_qf, prefix = "select-all+" },
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
