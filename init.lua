vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- init ui stuff
vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/ThorstenRhau/token" },
  { src = "https://github.com/szymonwilczek/arete.nvim" },
})

vim.cmd("colo ef-autumn")

require("lualine").setup({
  options = {
    always_show_tabline = false,
    component_separators = "",
    section_separators = "",
    disabled_filetypes = {
      statusline = { "fugitiveblame", "qf", "quifckfix" },
    },
  },
  sections = {
    lualine_a = {
      {
        "tabs",
        mode = 0,
        tabs_color = {
          active = "lualine_a_insert",
          inactive = "lualine_a_normal",
        },
      },
    },
    lualine_b = {
      "filesize",
    },
    lualine_c = {
      { "filename", path = 0 },
      "location",
      "progress",
    },
    lualine_x = { "diff" },
    lualine_y = { { "lsp_status", symbols = { separator = "  " } } },
    lualine_z = { "branch" },
  },
})
