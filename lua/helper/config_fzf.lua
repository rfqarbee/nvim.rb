local M = {}

local actions = require("fzf-lua.actions")

M.grep_opts = {
  rg_glob = true,
  glob_flag = "--iglob",
  glob_separator = "%s%-%-",
}

M.files = {
  ["enter"] = actions.file_edit_or_qf,
  ["ctrl-s"] = actions.file_split,
  ["ctrl-v"] = actions.file_vsplit,
  ["ctrl-t"] = actions.file_tabedit,
  ["alt-q"] = { fn = actions.file_edit_or_qf, prefix = "select-all+" },
  ["ctrl-q"] = actions.file_sel_to_qf,
  ["ctrl-a"] = actions.file_sel_to_ll,
}

return M
