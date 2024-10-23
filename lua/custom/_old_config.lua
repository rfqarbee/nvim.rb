-- unlikely be using this again, but
-- just incase switch to telescope again
-- these are the configs that i like
local M = {}

local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local Job = require("plenary.job")

M.telescope_mappings = {
  i = {
    -- ["<M-e>"] = actions.close,
    ["<C-s>"] = actions.select_horizontal, -- remap c-x
    ["<C-x>"] = actions.delete_buffer,
    ["<C-p>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.move_selection_next,
    ["<C-f>"] = actions.add_selection,
    ["<C-e>"] = actions.remove_selection,
    ["<S-Tab>"] = actions.drop_all,
    ["<C-q>"] = actions.send_selected_to_qflist,
    ["<C-a>"] = actions.add_selected_to_qflist,
    ["<C-l>"] = actions.send_selected_to_loclist,
    -- ["<C-m>"] = actions.add_selected_to_loclist,
    ["<M-q>"] = actions.send_to_qflist,
    ["<M-a>"] = actions.add_to_qflist,
    ["<M-l>"] = actions.send_to_loclist,
    ["<M-m>"] = actions.add_to_loclist,
    ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
    -- ["<C-o>"] = actions.nop,
    -- ["<C-t>"] = open_trouble,
  },
  n = {
    -- ["<M-e>"] = actions.close,
    ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
    ["<Tab>"] = actions.add_selection,
    ["<S-Tab>"] = actions.remove_selection,
    ["<C-s>"] = actions.select_horizontal, -- remap c-x
    ["e"] = actions.drop_all,
    ["x"] = actions.delete_buffer,
    ["q"] = actions.send_selected_to_qflist,
    ["a"] = actions.add_selected_to_qflist,
    ["l"] = actions.send_selected_to_loclist,
    -- ["m"] = actions.add_selected_to_loclist,
    ["Q"] = actions.send_to_qflist,
    ["A"] = actions.add_to_qflist,
    ["L"] = actions.send_to_loclist,
    ["M"] = actions.add_to_loclist,
    -- ["t"] = open_trouble,
  },
}

M.buffers = {
  initial_mode = "insert",
  mappings = {
    i = {
      ["<C-d>"] = actions.delete_buffer,
    },
    n = {
      ["<C-d>"] = actions.delete_buffer,
    },
  },
}

M.find_files = {
  find_command = {
    "rg",
    "--files",
    "--hidden",
    -- "-u",
    "--glob",
    "!**/.git/*",
  },
}

M.grep_string = {
  initial_mode = "normal",
}

M.current_buffer_fuzzy_find = {
  previewer = false,
}

M.telescope_new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end,
  }):sync()
end

M.vimgrep_arguments = {
  "rg",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--trim",
}

return M
