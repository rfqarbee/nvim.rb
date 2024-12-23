vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

-- auto space on =
autopairs.add_rule(Rule("=", "")
  :with_pair(cond.not_inside_quote())
  :with_pair(function(opts)
    local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
    if last_char:match("[%w%=%s]") then
      return true
    end
    return false
  end)
  :replace_endpair(function(opts)
    local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
    local next_char = opts.line:sub(opts.col, opts.col)
    next_char = next_char == " " and "" or " "
    if prev_2char:match("%w$") then
      return "<bs> =" .. next_char
    end
    if prev_2char:match("%=$") then
      return next_char
    end
    if prev_2char:match("=") then
      return "<bs><bs>=" .. next_char
    end
    return ""
  end)
  :set_end_pair_length(0)
  :with_move(cond.none())
  :with_del(cond.none()))
