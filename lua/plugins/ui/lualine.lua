local utils = require("helper.config_lualine")
local arrow_status = require("arrow.statusline")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      -- section_separators = { right = "", left = " " },
      component_separators = { right = "", left = "" },
      section_separators = { right = " ", left = " " },
      disabled_filetypes = {
        statusline = { "fzf", "trouble", "oil", "undotree", "TelescopePrompt" },
      },
    },
    sections = {
      lualine_a = { "branch" },
      lualine_b = { "mode", "diff" },
      lualine_c = {
        "diagnostics",
        {
          function()
            return arrow_status.text_for_statusline_with_icons()
          end,
        },
        {
          -- shamelessly stolen from reddit
          function()
            local hasloclist = utils.loclist_item()
            return "󰏬 " .. hasloclist
          end,

          cond = function()
            local hasloclist = utils.loclist_item()
            if hasloclist then
              return true
            end
          end,
        },
        {
          function()
            local hasqfix = utils.qfix_item()
            return "󰏬 " .. hasqfix
          end,
          cond = function()
            local hasqfix = utils.qfix_item()
            if hasqfix then
              return true
            end
          end,
          -- padding = { left = 20 },
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = {
        { "location" },
      },
    },
    -- extensions = { "fugitive", "trouble", "mason", "lazy" },
    tabline = {
      lualine_a = {
        {
          "tabs",
          -- NOTE: doom color
          tabs_color = {
            inactive = { bg = "#23272e", fg = "#a9a1e1" },
            active = { bg = "#3f444a", fg = "#98be75" },
          },
          tab_max_length = 40,
          max_legth = vim.o.columns / 3,
          mode = 1,
          path = 0,
          symbols = {
            modified = "",
          },
          -- FIX: no name during telescope/oil
          fmt = function(name, context)
            local buflist = vim.fn.tabpagebuflist(context.tabnr)
            local winnr = vim.fn.tabpagewinnr(context.tabnr)
            local bufnr = buflist[winnr]
            local mod = vim.fn.getbufvar(bufnr, "&mod")
            local tab = vim.fn.tabpagenr("#")
            local filetype = vim.bo.filetype

            if tab ~= context.tabnr then
              if filetype == "fzf" then
                return "Fzf"
              elseif filetype == "minifiles" then
                return "Mini files"
              elseif filetype == "oil" then
                return "Oil"
              else
                return (mod == 1 and "[+] " or "") .. name
              end
            else
              return (mod == 1 and "[+] " or "") .. name
            end
          end,
        },
      },
    },
  },
}
